# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "cask"
require "cask/download"
require "fileutils"
require "hardware"
require "macho"
require "pathname"
require "macos_version"
require "simulate_system"

module Homebrew
  module Cmd
    class BumpCaskMinMacos < AbstractCommand

      cmd_args do
        description <<~EOS
          Detect and update the minimum macOS version requirement for a cask.

          Fetches the cask artifact, inspects the bundle for LSMinimumSystemVersion
          or Mach-O minimum deployment target, and updates depends_on macos: if needed.
        EOS

        flag "--version=",
             description: "The new version to check (required for version bumps)."
        named_args :cask, number: 1, without_api: true
      end

      sig { override.void }
      def run
        cask = args.named.to_casks.first
        raise UsageError, "`cask` argument is required." if cask.blank?

        cask_file = cask.sourcefile_path
        raise UsageError, "Cask file not found: #{cask}" if cask_file.blank? || !cask_file.exist?

        new_version = args.version
        raise UsageError, "`--version` is required." if new_version.blank?

        output_github_output(false, nil, nil)

        unless cask_file.read.include?("depends_on macos:")
          puts "No depends_on macos: in #{cask_file}, skipping"
          return
        end

        current_symbol = cask_file.read[/">= :([a-z_]+)"/, 1]
        if current_symbol.nil? || current_symbol.empty?
          puts "Could not parse current macos symbol, skipping"
          return
        end
        puts "Current depends_on macos: :#{current_symbol}"

        symbol_rank = {
          "catalina" => 1015,
          "big_sur"  => 1100,
          "monterey" => 1200,
          "ventura"  => 1300,
          "sonoma"   => 1400,
          "sequoia"  => 1500,
        }

        version_to_symbol = lambda { |v|
          major_minor = v.split(".").first(2).join(".")
          case major_minor
          when "10.15" then "catalina"
          when "11"    then "big_sur"
          when "12"    then "monterey"
          when "13"    then "ventura"
          when "14"    then "sonoma"
          when "15"    then "sequoia"
          end
        }

        work_dir = Dir.mktmpdir
        begin
          modified_cask = create_modified_cask(cask, new_version)
          download = Cask::Download.new(modified_cask)
          cached_location = download.fetch(verify_download_integrity: false)
        rescue => e
          puts "Download failed: #{e.message}, skipping macOS version check"
          return
        end

        begin
          detected_min_os, found_binary = detect_min_os(cached_location, cask)
        rescue => e
          puts "Inspection failed: #{e.message}, skipping macOS version check"
          return
        end

        if detected_min_os.nil?
          puts "Could not determine minimum macOS version from cask download, skipping"
          return
        end

        min_os = detected_min_os
        min_os_normalized = MacOSVersion.new(min_os).strip_patch.to_s
        new_symbol = version_to_symbol.call(min_os_normalized)

        if new_symbol.nil?
          puts "Unknown version #{min_os_normalized}, skipping"
          return
        end
        puts "Required macOS symbol: :#{new_symbol} (from #{min_os_normalized})"

        new_rank = symbol_rank.fetch(new_symbol, 0)
        cur_rank = symbol_rank.fetch(current_symbol, 0)

        if new_rank > cur_rank
          puts "Bumping depends_on macos: from :#{current_symbol} to :#{new_symbol}"
          content = cask_file.read
          updated = content.sub(/depends_on macos: ">= :[a-z_]+"/, "depends_on macos: \">= :#{new_symbol}\"")
          cask_file.write(updated)
          output_github_output(true, current_symbol, new_symbol)
        else
          puts "No update needed (:#{current_symbol} covers #{min_os_normalized})"
        end
      ensure
        FileUtils.rm_rf(work_dir) if work_dir
      end

      private

      def create_modified_cask(cask, new_version)
        cask_source = cask.sourcefile_path.read
        modified_source = cask_source.sub(/^\s*version "[^"]+"/, "version \"#{new_version}\"")
        Cask::CaskLoader::FromContentLoader.new(modified_source).load(config: nil)
      end

      def detect_min_os(cached_location, cask)
        work_dir = Dir.mktmpdir
        extract_dir = "#{work_dir}/extracted"
        FileUtils.mkdir_p(extract_dir)

        container_type = cask.container&.type
        is_naked = container_type == :naked

        case cached_location.extname
        when ".zip"
          system("unzip", "-q", cached_location.to_s, "-d", extract_dir)
        when ".dmg"
          mount_point = "#{work_dir}/mnt"
          FileUtils.mkdir_p(mount_point)
          system("hdiutil", "attach", "-quiet", "-readonly", "-nobrowse",
                 "-mountpoint", mount_point, cached_location.to_s)
          Dir["#{mount_point}/*.app"].each { |app| FileUtils.cp_r(app, extract_dir) }
          system("hdiutil", "detach", "-quiet", mount_point)
        else
          if is_naked
            FileUtils.cp(cached_location, extract_dir)
          else
            FileUtils.cp(cached_location, extract_dir)
          end
        end

        min_os = nil
        found_binary = nil

        if is_naked
          min_os, found_binary = inspect_naked_binary(extract_dir, cached_location)
        else
          app_stanzas = cask.artifacts.select { |a| a.is_a?(Cask::Artifact::App) }
          app_names = app_stanzas.map { |a| a.instance_variable_get(:@source_string) }.compact

          Dir.glob("#{extract_dir}/**/*.app").each do |app_bundle|
            next unless app_stanzas.empty? || app_names.any? { |name| app_bundle.end_with?(name) || app_bundle.include?("/#{name}") }

            result = inspect_app_bundle(app_bundle)
            if result
              min_os, found_binary = result
              break
            end
          end
        end

        FileUtils.rm_rf(work_dir)
        min_os ? [min_os, found_binary] : nil
      end

      def inspect_naked_binary(extract_dir, cached_location)
        binary_path = Dir.glob("#{extract_dir}/*").find { |f| File.file?(f) }
        return nil unless binary_path

        first_bytes = File.read(binary_path, 2)
        if first_bytes == "#!"
          puts "Skipping script: #{binary_path}"
          return nil
        end

        begin
          macho = MachO.open(binary_path)
          min_os = case macho
          when MachO::MachOFile
            [
              macho[:LC_VERSION_MIN_MACOSX].first&.version_string,
              macho[:LC_BUILD_VERSION].first&.minos_string,
            ].compact.first
          when MachO::FatFile
            arch_min_os = { arm: [], intel: [] }
            macho.machos.each do |slice|
              macos_reqs = [
                slice[:LC_VERSION_MIN_MACOSX].first&.version_string,
                slice[:LC_BUILD_VERSION].first&.minos_string,
              ].compact

              case slice.cputype
              when *Hardware::CPU::ARM_ARCHS
                arch_min_os[:arm].concat(macos_reqs)
              when *Hardware::CPU::INTEL_ARCHS
                arch_min_os[:intel].concat(macos_reqs)
              end
            end
            candidate = arch_min_os.fetch(SimulateSystem.current_arch, [])
            candidate.max
          end

          if min_os
            puts "Found binary: #{binary_path}, min_os: #{min_os}"
            [min_os, binary_path]
          else
            nil
          end
        rescue MachO::NotAMachOError
          puts "Not a Mach-O file: #{binary_path}"
          nil
        rescue => e
          puts "Error reading #{binary_path}: #{e.message}"
          nil
        end
      end

      def inspect_app_bundle(app_bundle)
        plist_path = "#{app_bundle}/Contents/Info.plist"
        return nil unless File.exist?(plist_path)

        plist = `plutil -convert xml1 -o - #{plist_path}`.strip
        ls_min_os = plist[/<key>LSMinimumSystemVersion<\/key>\s*<string>([^<]+)<\/string>/m, 1]
        if ls_min_os.present?
          puts "Found LSMinimumSystemVersion: #{ls_min_os}"
          return [ls_min_os, "Info.plist LSMinimumSystemVersion"]
        end

        binary_name = plist[/<key>CFBundleExecutable<\/key>\s*<string>([^<]+)<\/string>/m, 1]
        return nil if binary_name.blank?

        binary_path = "#{app_bundle}/Contents/MacOS/#{binary_name}"
        return nil unless File.exist?(binary_path)

        first_bytes = File.read(binary_path, 2)
        if first_bytes == "#!"
          puts "Skipping script: #{binary_path}"
          return nil
        end

        begin
          macho = MachO.open(binary_path)
          min_os = case macho
          when MachO::MachOFile
            [
              macho[:LC_VERSION_MIN_MACOSX].first&.version_string,
              macho[:LC_BUILD_VERSION].first&.minos_string,
            ].compact.first
          when MachO::FatFile
            arch_min_os = { arm: [], intel: [] }
            macho.machos.each do |slice|
              macos_reqs = [
                slice[:LC_VERSION_MIN_MACOSX].first&.version_string,
                slice[:LC_BUILD_VERSION].first&.minos_string,
              ].compact

              case slice.cputype
              when *Hardware::CPU::ARM_ARCHS
                arch_min_os[:arm].concat(macos_reqs)
              when *Hardware::CPU::INTEL_ARCHS
                arch_min_os[:intel].concat(macos_reqs)
              end
            end
            candidate = arch_min_os.fetch(SimulateSystem.current_arch, [])
            candidate.max
          end

          if min_os
            puts "Found binary: #{binary_path}, min_os: #{min_os}"
            [min_os, binary_path]
          end
        rescue MachO::NotAMachOError
          puts "Not a Mach-O file: #{binary_path}"
          nil
        rescue => e
          puts "Error reading #{binary_path}: #{e.message}"
          nil
        end
      end

      def output_github_output(macos_updated, old_symbol, new_symbol)
        return unless ENV["GITHUB_OUTPUT"]

        File.open(ENV["GITHUB_OUTPUT"], "a") do |f|
          f.puts "macos_updated=#{macos_updated}"
          f.puts "old_macos_version=#{old_symbol || ""}"
          f.puts "new_macos_version=#{new_symbol || ""}"
        end
      end
    end
  end
end

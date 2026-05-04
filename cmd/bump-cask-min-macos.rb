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

        named_args :cask, number: 1, without_api: true
      end

      sig { override.void }
      def run
        cask = args.named.to_casks.first
        raise UsageError, "`cask` argument is required." if cask.blank?

        cask_file = cask.sourcefile_path
        raise UsageError, "Cask file not found: #{cask}" if cask_file.blank? || !cask_file.exist?

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
          download = Cask::Download.new(cask)
          cached_location = download.fetch

          extract_dir = "#{work_dir}/extracted"
          FileUtils.mkdir_p(extract_dir)

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
            FileUtils.cp(cached_location, extract_dir)
          end

          min_os = nil
          found_binary = nil

          Dir.glob("#{extract_dir}/**/*.app").each do |app_bundle|
            plist_path = "#{app_bundle}/Contents/Info.plist"
            next unless File.exist?(plist_path)

            plist = `plutil -convert xml1 -o - #{plist_path}`.strip
            ls_min_os = plist[/<key>LSMinimumSystemVersion<\/key>\s*<string>([^<]+)<\/string>/m, 1]
            if ls_min_os.present?
              min_os = ls_min_os
              found_binary = "Info.plist LSMinimumSystemVersion"
              puts "Found LSMinimumSystemVersion: #{min_os}"
              break
            end

            binary_name = plist[/<key>CFBundleExecutable<\/key>\s*<string>([^<]+)<\/string>/m, 1]
            next if binary_name.blank?

            binary_path = "#{app_bundle}/Contents/MacOS/#{binary_name}"
            next unless File.exist?(binary_path)

            first_bytes = File.read(binary_path, 2)
            if first_bytes == "#!"
              puts "Skipping script: #{binary_path}"
              next
            end

            begin
              macho = MachO.open(binary_path)

              case macho
              when MachO::MachOFile
                min_os = [
                  macho[:LC_VERSION_MIN_MACOSX].first&.version_string,
                  macho[:LC_BUILD_VERSION].first&.minos_string,
                ].compact.first
                found_binary = binary_path if min_os
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
                min_os = candidate.max
                found_binary = binary_path if min_os
              end

              if min_os
                puts "Found binary: #{found_binary}, min_os: #{min_os}"
                break
              end
            rescue MachO::NotAMachOError
              puts "Not a Mach-O file: #{binary_path}"
            rescue => e
              puts "Error reading #{binary_path}: #{e.message}"
            end
          end

          if min_os.nil?
            puts "Could not determine minimum macOS version from cask download, skipping"
            return
          end

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
      end

      private

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

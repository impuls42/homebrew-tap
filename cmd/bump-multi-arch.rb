# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "formula"
require "formulary"
require "resource"
require "simulate_system"
require "utils/inreplace"

module Homebrew
  module Cmd
    class BumpMultiArchCmd < AbstractCommand
      cmd_args do
        description <<~EOS
          Update a multi-architecture formula to a new version.

          Iterates all OS/architecture combinations using SimulateSystem,
          downloads each platform's artifact, computes the new SHA-256
          checksum, and writes all changes to the formula file in one pass.

          This is the formula equivalent of what `bump-cask-pr` does for
          casks with `on_system` blocks.
        EOS

        flag   "--version=",
               description: "The new version to bump to (required)."
        switch "-n", "--dry-run",
               description: "Print what would be changed without writing."
        switch "--write-only",
               description: "Write changes to the formula file only (no git/PR actions)."

        named_args :formula, min: 1, max: 1
      end

      sig { override.void }
      def run
        new_version = args.version
        raise UsageError, "`--version` is required." if new_version.blank?

        formula = args.named.to_formulae.first
        raise FormulaUnspecifiedError if formula.blank?

        old_version = formula.version.to_s

        if old_version == new_version
          ohai "#{formula.name} is already at version #{new_version}"
          return
        end

        ohai "Bumping #{formula.name} from #{old_version} to #{new_version}"

        replacement_pairs = []
        formula_source = formula.path.read

        # Iterate every OS/arch combination, mirroring bump-cask-pr's approach.
        OnSystem::BASE_OS_OPTIONS.product(OnSystem::ARCH_OPTIONS).each do |os, arch|
          SimulateSystem.with(os:, arch:) do
            sim_formula = begin
              Formulary.factory(formula.full_name)
            rescue FormulaUnavailableError, TapFormulaUnavailableError
              nil
            end
            next if sim_formula.nil?

            spec = sim_formula.stable
            next if spec.nil?

            old_url = spec.url
            next if old_url.blank?

            old_sha = spec.checksum&.hexdigest
            new_url = old_url.gsub(old_version, new_version)

            if old_url == new_url
              opoo "#{os}/#{arch}: URL unchanged after version substitution, skipping."
              next
            end

            ohai "#{os}/#{arch}: fetching #{new_url}"

            # Download the new artifact and compute its SHA-256.
            resource = Resource.new("bump-#{os}-#{arch}")
            resource.url(new_url)
            resource.owner = Resource.new(formula.name)
            path = resource.fetch(verify_download_integrity: false)
            new_sha = path.sha256

            ohai "#{os}/#{arch}: #{new_sha}"

            # Queue replacement pairs.
            # Only include the URL pair when the old URL appears literally in the
            # source file.  Formulas that build URLs dynamically (e.g. via a
            # CHECKSUMS hash + helper method) won't have a literal URL to match,
            # but their SHA-256 values and version string are always literals and
            # will be replaced by the pairs queued below.
            replacement_pairs << [old_url, new_url] if old_url != new_url && formula_source.include?(old_url)
            replacement_pairs << [old_sha, new_sha] if old_sha && old_sha != new_sha
          end
        end

        # Replace the version string itself.
        replacement_pairs << [
          "version \"#{old_version}\"",
          "version \"#{new_version}\"",
        ]

        replacement_pairs = replacement_pairs.uniq.compact
        replacement_pairs.reject! { |old_val, new_val| old_val == new_val }

        if replacement_pairs.empty?
          ohai "No changes needed."
          return
        end

        if args.dry_run?
          puts "Replacement pairs that would be applied to #{formula.path}:"
          replacement_pairs.each do |old_val, new_val|
            old_display = old_val.to_s.length > 72 ? "#{old_val.to_s[0..68]}..." : old_val
            new_display = new_val.to_s.length > 72 ? "#{new_val.to_s[0..68]}..." : new_val
            puts "  #{old_display}"
            puts "  → #{new_display}"
            puts
          end
          return
        end

        Utils::Inreplace.inreplace_pairs(
          formula.path,
          replacement_pairs,
          read_only_run: false,
          silent:        args.quiet?,
        )

        ohai "Updated #{formula.path}"
      end
    end
  end
end

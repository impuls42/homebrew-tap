class SpotctlMcp < Formula
  desc "Rackspace Spot CLI with MCP server and VM support (impuls42 fork)"
  homepage "https://github.com/impuls42/spotctl"
  version "0.3.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the release tarball naming convention.
  RELEASE_BASE = "https://github.com/impuls42/spotctl/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "c57d7a78fe2516347ae5aca33f0f7815ac814f8f18ec46c4193dbf0d28877e43",
    "darwin_arm64" => "464bd3b64fe011ee326cd122d6cf44a3704034832347862d9f5fc040f516847a",
    "linux_amd64"  => "99885fd9afc2a14d2fdbe3ebecf8c4e10cc1b866cac5cb2129bcd68e9ff0af31",
    "linux_arm64"  => "99d29ee0255edaaf1ef3b3811a54c3a9f419c0ddfba6597145d6bb2b6f371bf4",
  }.freeze

  # Registers the correct url + sha256 for a given platform key.
  def self.artifact(platform)
    url "#{RELEASE_BASE}/v#{version}/spotctl_#{version}_#{platform}.tar.gz"
    sha256 CHECKSUMS[platform]
  end

  on_macos do
    on_intel { artifact "darwin_amd64" }
    on_arm   { artifact "darwin_arm64" }
  end

  on_linux do
    on_intel { artifact "linux_amd64" }
    on_arm   { artifact "linux_arm64" }
  end

  # Installs the same `spotctl` binary as the upstream formula.
  conflicts_with "spotctl", because: "both install a `spotctl` binary"

  def install
    bin.install "spotctl"
  end

  def caveats
    <<~EOS
      This is the impuls42 fork of spotctl (adds an MCP server, VM commands,
      and node-pool autoscaling). It installs the same `spotctl` binary as the
      upstream `spotctl` formula, so the two cannot be installed at the same time.

      Run `spotctl configure` to set up your organization, token, and region.
      MCP server:  spotctl mcp
      Docs: https://github.com/impuls42/spotctl
    EOS
  end

  test do
    # Verify the binary reports the expected version
    assert_match version.to_s, shell_output("#{bin}/spotctl --version")

    # Smoke-test: help output should exit cleanly and mention the MCP subcommand
    assert_match "mcp", shell_output("#{bin}/spotctl --help")
  end
end

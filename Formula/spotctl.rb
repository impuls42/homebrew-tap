class Spotctl < Formula
  desc "CLI tool for managing Rackspace Spot resources"
  homepage "https://github.com/rackspace-spot/spotctl"
  version "0.1.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>-<arch>" — mirrors the upstream binary naming convention.
  RELEASE_BASE = "https://github.com/rackspace-spot/spotctl/releases/download".freeze
  CHECKSUMS = {
    "darwin-amd64" => "82ae1b7cf2c4b1b9fa41ea7b870ce26a6dd3b0519cf603c34953c61452b8152c",
    "darwin-arm64" => "cf19c982cf7a831a0c1884abccbcbc88655c8b3bea7fe277d4ec697cf19606d3",
    "linux-amd64"  => "c099e6fa3b2a1b885a1a52b249efb4be842480a4bc5f1353c94779bb2886472a",
    "linux-arm64"  => "c372f9c272ae0eb9d0ae87c7afc80df12073c464335e8e22e500a2bd11dc67ac",
  }.freeze

  # Registers the correct url + sha256 for a given platform key.
  def self.artifact(platform)
    url "#{RELEASE_BASE}/v#{version}/spotctl-#{platform}"
    sha256 CHECKSUMS[platform]
  end

  on_macos do
    on_intel { artifact "darwin-amd64" }
    on_arm   { artifact "darwin-arm64" }
  end

  on_linux do
    on_intel { artifact "linux-amd64" }
    on_arm   { artifact "linux-arm64" }
  end

  def install
    os   = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "spotctl-#{os}-#{arch}" => "spotctl"

    # Generate shell completions if the binary supports them
    generate_completions_from_executable(bin/"spotctl", "completion")
  end

  def caveats
    <<~EOS
      spotctl requires a Spot API token to authenticate. You can provide it via:
        - The SPOT_TOKEN environment variable (recommended):
            export SPOT_TOKEN="<your-token>"
        - The --token flag on each command:
            spotctl --token <your-token> <command>

      Docs: https://github.com/rackspace-spot/spotctl
    EOS
  end

  test do
    # Verify the binary reports the expected version
    assert_match version.to_s, shell_output("#{bin}/spotctl --version")

    # Smoke-test: help output should exit cleanly
    assert_match "spotctl", shell_output("#{bin}/spotctl --help")
  end
end

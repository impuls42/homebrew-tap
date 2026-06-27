class Spotctl < Formula
  desc "CLI tool for managing Rackspace Spot resources"
  homepage "https://github.com/rackspace-spot/spotctl"
  version "0.2.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>-<arch>" — mirrors the upstream binary naming convention.
  RELEASE_BASE = "https://github.com/rackspace-spot/spotctl/releases/download".freeze
  CHECKSUMS = {
    "darwin-amd64" => "b1320ee9fdab622051e3b1dfc858097492f08f1cd5c08f5f34734872515980d8",
    "darwin-arm64" => "9f5eb1077b2918b8cb6d0a7bb3f0ec0390584d7d88d379fa52efcc70280e6505",
    "linux-amd64"  => "2add5c920524bdb9ac3f78eca9d6c66382ee1b70d43934e7387b1fe51853f278",
    "linux-arm64"  => "dff5021d00d45a379dc4144129139b6d6073e10d4bb23e90ac675eeb1f06d25b",
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

  # The impuls42 fork installs the same `spotctl` binary.
  conflicts_with "spotctl-mcp", because: "both install a `spotctl` binary"

  def install
    os   = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "spotctl-#{os}-#{arch}" => "spotctl"
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

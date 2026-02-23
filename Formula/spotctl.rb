class Spotctl < Formula
  desc "CLI tool for managing Rackspace Spot resources"
  homepage "https://github.com/rackspace-spot/spotctl"
  version "0.1.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/rackspace-spot/spotctl/releases/download/v0.1.1/spotctl-darwin-amd64"
      sha256 "82ae1b7cf2c4b1b9fa41ea7b870ce26a6dd3b0519cf603c34953c61452b8152c"
    end

    on_arm do
      url "https://github.com/rackspace-spot/spotctl/releases/download/v0.1.1/spotctl-darwin-arm64"
      sha256 "cf19c982cf7a831a0c1884abccbcbc88655c8b3bea7fe277d4ec697cf19606d3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/rackspace-spot/spotctl/releases/download/v0.1.1/spotctl-linux-amd64"
      sha256 "c099e6fa3b2a1b885a1a52b249efb4be842480a4bc5f1353c94779bb2886472a"
    end

    on_arm do
      url "https://github.com/rackspace-spot/spotctl/releases/download/v0.1.1/spotctl-linux-arm64"
      sha256 "c372f9c272ae0eb9d0ae87c7afc80df12073c464335e8e22e500a2bd11dc67ac"
    end
  end

  def install
    bin.install Dir["spotctl*"].first => "spotctl"
  end

  def caveats
    <<~EOS
      To use spotctl, you need to authenticate with your Spot API token.
      Set the SPOT_TOKEN environment variable or use the --token flag.

      For more information, see: https://github.com/rackspace-spot/spotctl
    EOS
  end

  test do
    system "#{bin}/spotctl", "--version"
  end
end

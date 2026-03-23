class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.20.3"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the upstream tarball naming convention.
  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "2545c34534adaed7c1292fc68aaedf468dd64002043cb6be9148bd48c08021a3",
    "darwin_arm64" => "b6ce97009000c44439dc18eb55c99b41c497c8fe95d0b7e49b237f9ec5ccc1f5",
    "linux_amd64"  => "1a0a4779592c5136725c4839ae71dbfc3aaa59bb22cd4b01f2ca55a583f26b9d",
    "linux_arm64"  => "d14ae009238df34870b44761dcd93ab1e3e7abec7e2be96e98eef2c6fce80d28",
  }.freeze

  # Registers the correct url + sha256 for a given platform key.
  def self.artifact(platform)
    url "#{RELEASE_BASE}/v#{version}/dagger_v#{version}_#{platform}.tar.gz"
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

  def install
    bin.install "./dagger"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dagger version")
  end
end

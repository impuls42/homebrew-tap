class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.21.5"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the upstream tarball naming convention.
  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "ad71f284fc70d164f49ab4def4f458f24b1d5dfc1e3981fa5b08fee73a77bed4",
    "darwin_arm64" => "61f52448927cfbd5715f0385f47e1f500ccef54d80c72ffdf9404884c2e650b3",
    "linux_amd64"  => "66d5120cab472d3eb99971079d6872d43f11d4244ab08e32a80d7e31ea0f3b42",
    "linux_arm64"  => "0f7ea24a9b783be0fc54d512c9921454640b0b0b0355ffe382e3245c2145e5e3",
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

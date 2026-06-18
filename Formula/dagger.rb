class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.21.7"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the upstream tarball naming convention.
  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "883b30499067c68903bd4c53088a70640fd8a3044d2ac02bd7787cfcf365017b",
    "darwin_arm64" => "bb1472cd71efe40b9a5d192944eb0b095e8f5566e1879d16864f2d60e79d9c77",
    "linux_amd64"  => "44430afc6f9c390fc47c4f352b15de9309a5e97ebd1ae563839617d6df8e8cc5",
    "linux_arm64"  => "780e8ddc4269aeee94ef21ab7cb06ca2ee04abec5486eba53f49a7549d99637d",
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

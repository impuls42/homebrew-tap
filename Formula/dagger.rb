class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.21.6"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the upstream tarball naming convention.
  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "2512ec5ffccf99889b50a753ea1413e7464d8022492a4648a56792926d0c4416",
    "darwin_arm64" => "e69f40cb8e3dfdd6cfdf68e30eb4d9d7d95c3ad1bc85e40b95503e861e0d63a6",
    "linux_amd64"  => "0b10f5f464843dc154fae47279ad66e465d75a2118b32151394b7383c0eaac4f",
    "linux_arm64"  => "2fe36aca2a392152c6f1fc1e866638733cbd93720aaae77005d483ab3eba0f82",
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

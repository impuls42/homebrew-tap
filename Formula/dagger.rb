class Dagger < Formula
  desc "Dagger is an integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.20.1"

  livecheck do
    url :stable
    strategy :github_latest
  end

  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "1a44b55783dcc0ad22a913cc54ddcae4e682b4748a9be44fefb4b18628006b8a",
    "darwin_arm64" => "e735d38d50834f37265605a5ef6955a2f28bff4997f1e324d6de55cd8f0d5215",
    "linux_amd64"  => "012afa819a9d459389af34f1055c064dc117881080bf91dc31a6b4694f2bcf99",
    "linux_arm64"  => "da4da814e0a37540c88bd107ea4667bcdae1480a6656088f41ecad18f02b6334",
  }.freeze

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
    os   = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "./dagger"
  end

  test do
    system "#{bin}/dagger version"
  end
end
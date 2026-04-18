class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.20.6"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the upstream tarball naming convention.
  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "1274c1f109206c728dd5bf7cac58e21e25dccfec838dae208bdab9b495c92263",
    "darwin_arm64" => "6d31d7bf9d49f0cde343f45e08c698fb82447e29db7c71cf85aeb5eddbf1bba6",
    "linux_amd64"  => "3bfccb841a6954ee6b46c0abef77572a30c4aa50661ff72fb9340de0421e2f45",
    "linux_arm64"  => "1018e2b0b1becae3650428902b841db82c85fe21cf0b22fefcef839d30d51989",
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

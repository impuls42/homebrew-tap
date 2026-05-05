class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.20.7"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the upstream tarball naming convention.
  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "723c9efb9d11f9f389aeac74faea27a9e3df9de3b52bf719c05629dde20a136d",
    "darwin_arm64" => "8fed8b3740fc166195f777f8c01e2dc86af616b3f419dbb7d04d63cf995a32a0",
    "linux_amd64"  => "cc993d3a3625501dab1bc521aedb84dce53e2dba337f9913e14a9b3ead1686af",
    "linux_arm64"  => "03ed0cf87f13681501d0e00b385247a897dcff5baa74cd57d6cd03d5b0de3be0",
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

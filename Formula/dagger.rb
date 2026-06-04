class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.21.4"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the upstream tarball naming convention.
  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "4219176bd0bc8e10aca717e91d826c1e64bbff9184d772846b5ea627558ff6e2",
    "darwin_arm64" => "91bda59ac41a230c2d95e4cde08a24c6842a00347e49769068892254f584bb25",
    "linux_amd64"  => "4db2f807b67e3160fb110bb1e088b14c516594b8d287114a39c980f2485e9672",
    "linux_arm64"  => "d4610ec53c77eef7a5610b732b9e9b0d26c3f1c5911ef99e5e8e5c9e7cf6880e",
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

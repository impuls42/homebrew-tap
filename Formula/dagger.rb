class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.20.8"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the upstream tarball naming convention.
  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "4d8d78999660ff05efc3dd01c29ca6b02379d74deeb14c56a7c6f589620c9360",
    "darwin_arm64" => "44cbfe7ee8748895f851c3765c84fe023c7dcb6546f6d9cff81a912ae0ea9f25",
    "linux_amd64"  => "c0a46536fde641f6a4b45529382e1176220d22552c2f9ab0136deaf005e646db",
    "linux_arm64"  => "e49f3aa146f3af2c259f94bc335dffe154664eddff4db0adf445d650345e0056",
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

class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.21.3"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Single source of truth for all release artifacts.
  # Key format: "<os>_<arch>" — mirrors the upstream tarball naming convention.
  RELEASE_BASE = "https://github.com/dagger/dagger/releases/download".freeze
  CHECKSUMS = {
    "darwin_amd64" => "d127aa9a461f64311ff8950d542ced3e0e850822e345712cf7a7276fd6e4b67a",
    "darwin_arm64" => "803ce37ea2c6a4871f41cf797d258ec335af30a3854650adab0686b0ec3850e1",
    "linux_amd64"  => "646aa0696f607cc1aac8921e7c109db0016fd431911b1e862b0079394875eff1",
    "linux_arm64"  => "0ec92cf72198cb5c5e7251c7c5688463f53592b3caf2059edc0e151b24cbe9a2",
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

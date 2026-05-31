class Mux < Formula
  desc "Desktop app for isolated, parallel agentic development"
  homepage "https://github.com/coder/mux"
  version "0.26.0"
  license "AGPL-3.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :linux

  # mux ships prebuilt AppImages for Linux only (x86_64 and arm64).
  # Key format mirrors the upstream AppImage arch naming.
  RELEASE_BASE = "https://github.com/coder/mux/releases/download".freeze
  CHECKSUMS = {
    "x86_64" => "d268ed5799580af90431a20e2ba504c5daf5d8ddbc4919535ea37046d6eb95a5",
    "arm64"  => "4af3bc36d1fc6bd36d2825e3870d013576e5e58ed27e305bd27d53f452ecc048",
  }.freeze

  # Registers the correct url + sha256 for a given AppImage arch.
  def self.artifact(arch)
    url "#{RELEASE_BASE}/v#{version}/mux-#{version}-#{arch}.AppImage"
    sha256 CHECKSUMS[arch]
  end

  # Only Linux is installable (see depends_on :linux above); the macOS spec
  # exists solely so audit/livecheck can resolve a url on the CI runner.
  on_macos do
    on_intel { artifact "x86_64" }
    on_arm   { artifact "arm64" }
  end

  on_linux do
    on_intel { artifact "x86_64" }
    on_arm   { artifact "arm64" }
  end

  def install
    bin.install Dir["mux-*.AppImage"].first => "mux"
    (bin/"mux").chmod 0755
  end

  def caveats
    <<~EOS
      mux is distributed as an AppImage and needs FUSE at runtime.
      On Debian/Ubuntu/Raspberry Pi OS:
        sudo apt install libfuse2

      Alternatively, run it without FUSE:
        mux --appimage-extract-and-run

      Only 64-bit Linux (x86_64 / arm64) is supported upstream.
    EOS
  end

  test do
    assert_path_exists bin/"mux"
    assert_predicate bin/"mux", :executable?
  end
end

class Mux < Formula
  desc "Desktop app for isolated, parallel agentic development"
  homepage "https://github.com/coder/mux"
  version "0.27.0"
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
    "x86_64" => "fb38c859822b34873918f20a95eb0a9fd8857170ef9dc8aa883465005648e371",
    "arm64"  => "889371c393e59165c00a47d41d5a95696c43fe9645965ffbcd8246bc5183b58b",
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

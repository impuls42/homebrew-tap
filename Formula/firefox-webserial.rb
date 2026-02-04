class FirefoxWebserial < Formula
  desc "Native messaging host for WebSerial API polyfill for Firefox"
  homepage "https://github.com/kuba2k2/firefox-webserial"
  url "https://github.com/kuba2k2/firefox-webserial/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "8da579754ce88e18cc20a4702a4523765c6d3c07c859193e3ffa50797f8dbe9b"
  license "MIT"

  depends_on "platformio" => :build

  def install
    cd "native" do
      # Determine the environment based on architecture
      env_name = if Hardware::CPU.arm?
        "macos_arm64"
      else
        "macos_x86_64"
      end

      # Build the native binary using PlatformIO
      system "platformio", "run", "-e", env_name

      # Install the binary to Homebrew's bin directory
      bin.install ".pio/build/#{env_name}/program" => "firefox-webserial"
    end

    # Create a helper script for post-installation setup
    (prefix/"setup.sh").write <<~EOS
      #!/bin/bash
      set -e

      TARGET_DIR="$HOME/Library/Application Support/Mozilla/NativeMessagingHosts"
      mkdir -p "$TARGET_DIR"

      # Create symlink to the binary
      ln -sf "#{bin}/firefox-webserial" "$TARGET_DIR/firefox-webserial"

      # Create the manifest JSON file
      cat > "$TARGET_DIR/io.github.kuba2k2.webserial.json" << 'EOF'
      {
        "name": "io.github.kuba2k2.webserial",
        "description": "WebSerial for Firefox",
        "path": "#{bin}/firefox-webserial",
        "type": "stdio",
        "allowed_extensions": ["webserial@kuba2k2.github.io"]
      }
      EOF

      echo "✓ Firefox WebSerial native host installed successfully"
      echo "  Binary: $TARGET_DIR/firefox-webserial"
      echo "  Manifest: $TARGET_DIR/io.github.kuba2k2.webserial.json"
    EOS
    chmod 0755, prefix/"setup.sh"
  end

  def post_install
    # Run the setup script automatically
    system prefix/"setup.sh"
  end

  def caveats
    <<~EOS
      To complete the installation, run:
        #{prefix}/setup.sh

      Or manually create a symlink and manifest:
        mkdir -p ~/Library/Application\\ Support/Mozilla/NativeMessagingHosts
        ln -sf #{bin}/firefox-webserial ~/Library/Application\\ Support/Mozilla/NativeMessagingHosts/firefox-webserial

      Then install the Firefox extension from:
        https://addons.mozilla.org/firefox/addon/webserial-for-firefox/
    EOS
  end

  test do
    system "true"
  end
end

cask "firefox-webserial" do
  version "0.5.0"
  sha256 arm:   "7910be9e33e178780987d1229e18818ec3a04e5942629923864624e9bbadff7c",
         intel: "8f844c157bd7444b7f5f07227c8c78e68ce231d647d2ef7bb7f71e3824bfecfe"

  on_arm do
    url "https://github.com/kuba2k2/firefox-webserial/releases/download/v#{version}/firefox-webserial-macos-arm64"
  end
  on_intel do
    url "https://github.com/kuba2k2/firefox-webserial/releases/download/v#{version}/firefox-webserial-macos-x86-64"
  end

  name "WebSerial for Firefox"
  desc "Native messaging host for WebSerial API polyfill for Firefox"
  homepage "https://github.com/kuba2k2/firefox-webserial"

  livecheck do
    url :url
    strategy :github_releases
  end

  container type: :naked

  # No artifacts stanza needed - everything is handled in postflight

  postflight do
    target_dir = "#{Dir.home}/Library/Application Support/Mozilla/NativeMessagingHosts"
    system_command "/bin/mkdir", args: ["-p", target_dir]

    # Determine the correct source filename based on architecture
    source_file = Hardware::CPU.arm? ? "firefox-webserial-macos-arm64" : "firefox-webserial-macos-x86-64"

    # Copy the binary to target directory
    system_command "/bin/cp",
                   args: ["#{staged_path}/#{source_file}",
                          "#{target_dir}/firefox-webserial"]

    # Make it executable
    system_command "/bin/chmod",
                   args: ["+x", "#{target_dir}/firefox-webserial"]

    # Create the manifest JSON file
    manifest_path = "#{target_dir}/io.github.kuba2k2.webserial.json"
    File.write manifest_path, <<~JSON
      {
        "name": "io.github.kuba2k2.webserial",
        "description": "WebSerial for Firefox",
        "path": "#{Dir.home}/Library/Application Support/Mozilla/NativeMessagingHosts/firefox-webserial",
        "type": "stdio",
        "allowed_extensions": ["webserial@kuba2k2.github.io"]
      }
    JSON
  end

  uninstall delete: [
    "#{Dir.home}/Library/Application Support/Mozilla/NativeMessagingHosts/firefox-webserial",
    "#{Dir.home}/Library/Application Support/Mozilla/NativeMessagingHosts/io.github.kuba2k2.webserial.json",
  ]

  zap trash: [
    "~/Library/Application Support/Mozilla/NativeMessagingHosts/firefox-webserial",
    "~/Library/Application Support/Mozilla/NativeMessagingHosts/io.github.kuba2k2.webserial.json",
  ]
end

cask "krokiet" do
  version "11.0.1"
  sha256 "04bc51fa769e8373ef6c2425c08cd7016b2cc826ec29e25d3a403bc8a56e8a70"

  url "https://github.com/qarmin/czkawka/releases/download/#{version}/mac_krokiet_arm64"
  name "krokiet"
  desc "Czkawka frontend written in Slint"
  homepage "https://github.com/qarmin/czkawka"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: ">= :catalina"
  depends_on arch: :arm64
  container type: :naked

  app "Krokiet.app"

  preflight do
    app_path = staged_path/"Krokiet.app"
    system_command "/bin/mkdir",
                   args: ["-p", "#{app_path}/Contents/MacOS"]
    system_command "/bin/mv",
                   args: ["#{staged_path}/mac_krokiet_arm64",
                          "#{app_path}/Contents/MacOS/Krokiet"]
    system_command "/bin/chmod",
                   args: ["+x", "#{app_path}/Contents/MacOS/Krokiet"]

    File.write app_path/"Contents/Info.plist", <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" \
        "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>CFBundleIdentifier</key><string>pl.Qarmin.Krokiet</string>
          <key>CFBundleName</key><string>Krokiet</string>
          <key>CFBundleExecutable</key><string>Krokiet</string>
          <key>CFBundleVersion</key><string>#{version}</string>
          <key>CFBundlePackageType</key><string>APPL</string>
        </dict>
      </plist>
    PLIST

    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "--timestamp=none", app_path]
  end

  zap trash: [
    "~/Library/Application Support/pl.Qarmin.Krokiet",
    "~/Library/Caches/pl.Qarmin.Krokiet",
  ]
end

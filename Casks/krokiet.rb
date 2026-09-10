cask "krokiet" do
  version "12.0.2"
  sha256 "e143fbdc50a2ce5719db5e6311bf6f21728ad13a7bbd065e4f0f83c14573f436"

  url "https://github.com/qarmin/czkawka/releases/download/#{version}/mac_krokiet_arm64"
  name "krokiet"
  desc "Czkawka frontend written in Slint"
  homepage "https://github.com/qarmin/czkawka"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :big_sur
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

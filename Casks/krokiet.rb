cask "krokiet" do
  version "12.0.2"
  sha256 "e143fbdc50a2ce5719db5e6311bf6f21728ad13a7bbd065e4f0f83c14573f436"

  url "https://github.com/qarmin/czkawka/releases/download/#{version}/mac_krokiet_arm64"
  name "Krokiet"
  desc "Czkawka frontend written in Slint"
  homepage "https://github.com/qarmin/czkawka"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on arch: :arm64
  depends_on :macos
  container type: :naked

  app "Krokiet.app"

  preflight_steps do
    # Upstream ships a bare executable, so build the app bundle around it.
    mkdir_p "Krokiet.app/Contents/MacOS"
    move "mac_krokiet_arm64", "Krokiet.app/Contents/MacOS/krokiet-bin"

    # The video tools (similar videos, broken files, video optimizer) shell out to
    # ffmpeg/ffprobe and resolve them on PATH. Apps launched from Finder or the Dock
    # inherit launchd's minimal PATH - /usr/bin:/bin:/usr/sbin:/sbin - which excludes
    # the Homebrew prefix, so Krokiet reports both as missing even when installed.
    # Launch through a wrapper that puts Homebrew on PATH first.
    write_file "Krokiet.app/Contents/MacOS/Krokiet", <<~SH
      #!/bin/sh
      PATH="{{HOMEBREW_PREFIX}}/bin:{{HOMEBREW_PREFIX}}/sbin:${PATH:-/usr/bin:/bin:/usr/sbin:/sbin}"
      export PATH
      exec "$(dirname "$0")/krokiet-bin" "$@"
    SH

    set_permissions ["Krokiet.app/Contents/MacOS/Krokiet",
                     "Krokiet.app/Contents/MacOS/krokiet-bin"], "0755"

    write_file "Krokiet.app/Contents/Info.plist", <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" \
        "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>CFBundleIdentifier</key><string>pl.Qarmin.Krokiet</string>
          <key>CFBundleName</key><string>Krokiet</string>
          <key>CFBundleExecutable</key><string>Krokiet</string>
          <key>CFBundleVersion</key><string>{{version}}</string>
          <key>CFBundleShortVersionString</key><string>{{version}}</string>
          <key>CFBundlePackageType</key><string>APPL</string>
          <key>NSHighResolutionCapable</key><true/>
        </dict>
      </plist>
    PLIST

    # krokiet-bin arrives ad-hoc signed in its own right. As a nested component it
    # must be re-signed, or `codesign --verify` rejects the bundle as a whole.
    run "/usr/bin/codesign",
        args:           ["--remove-signature", "{{staged_path}}/Krokiet.app/Contents/MacOS/krokiet-bin"],
        must_succeed:   false,
        writable_paths: ["Krokiet.app"]
    run "/usr/bin/codesign",
        args:           ["--force", "--sign", "-", "--timestamp=none",
                         "{{staged_path}}/Krokiet.app/Contents/MacOS/krokiet-bin"],
        writable_paths: ["Krokiet.app"]
    run "/usr/bin/codesign",
        args:           ["--force", "--sign", "-", "--timestamp=none", "{{staged_path}}/Krokiet.app"],
        writable_paths: ["Krokiet.app"]
  end

  zap trash: [
    "~/Library/Application Support/pl.Qarmin.Krokiet",
    "~/Library/Caches/pl.Qarmin.Czkawka",
    "~/Library/Caches/pl.Qarmin.Krokiet",
    "~/Library/Preferences/pl.Qarmin.Krokiet.plist",
  ]

  caveats <<~EOS
    The video tools (similar videos, broken files, video optimizer) need ffmpeg:
      brew install ffmpeg
  EOS
end

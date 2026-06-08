cask "xpra-beta" do
  arch arm: "arm64"

  version "6.5,40777"
  sha256 arm: "bf02760872ceb1beeefe238af96c8d57364edcba849e581539f1b96d5afe140a"

  revision_suffix = version.csv.second.present? ? "-r#{version.csv.second}" : ""
  url "https://xpra.org/beta/MacOS/#{arch}/Xpra-#{arch}-#{version.csv.first}#{revision_suffix}.dmg"
  name "Xpra Beta"
  desc "Screen and application forwarding system (beta builds)"
  homepage "https://xpra.org/"

  livecheck do
    url "https://xpra.org/beta/MacOS/arm64/"
    regex(/Xpra-arm64[_-]v?(\d+(?:\.\d+)+)-r(\d+)\.dmg["' >]/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map do |match|
        v, r = match
        "#{v},#{r}"
      end
    end
  end

  conflicts_with cask: "xpra"
  depends_on macos: :monterey

  app "Xpra.app"

  shimscript = "#{HOMEBREW_PREFIX}/bin/xpra"

  preflight do
    FileUtils.rm shimscript, force: true
  end

  postflight do
    File.write shimscript, <<~EOS
      #!/bin/sh
      exec #{appdir}/Xpra.app/Contents/MacOS/Xpra "$@"
    EOS
    File.chmod 0755, shimscript

    system_command "/usr/bin/codesign",
                   args:         ["--force", "--deep", "--sign", "-", "#{appdir}/Xpra.app"],
                   must_succeed: false
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Xpra.app"],
                   must_succeed: false
  end

  uninstall delete: "#{HOMEBREW_PREFIX}/bin/xpra"

  zap delete: "/Library/Application Support/Xpra",
      trash:  [
        "~/Library/Application Support/Xpra",
        "~/Library/Saved Application State/org.xpra.xpra.savedState",
      ]
end

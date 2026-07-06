cask "xpra" do
  arch arm: "arm64"

  version "6.5.1,0"
  sha256 arm: "a64d9f06483a415f2490455f13b639af585274653a026075ecc6b4e57caa59d3"

  revision_suffix = version.csv.second.present? ? "-r#{version.csv.second}" : ""
  url "https://xpra.org/dists/MacOS/#{arch}/Xpra-#{arch}-#{version.csv.first}#{revision_suffix}.dmg"
  name "Xpra"
  desc "Screen and application forwarding system"
  homepage "https://xpra.org/"

  livecheck do
    url "https://xpra.org/dists/MacOS/arm64/"
    regex(/Xpra-arm64[_-]v?(\d+(?:\.\d+)+)-r(\d+)\.dmg["' >]/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map do |match|
        v, r = match
        "#{v},#{r}"
      end
    end
  end

  conflicts_with cask: "xpra-beta"
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
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Xpra.app"]
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Xpra.app"]
  end

  uninstall delete: "#{HOMEBREW_PREFIX}/bin/xpra"

  zap delete: "/Library/Application Support/Xpra",
      trash:  [
        "~/Library/Application Support/Xpra",
        "~/Library/Saved Application State/org.xpra.xpra.savedState",
      ]
end

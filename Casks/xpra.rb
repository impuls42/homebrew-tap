cask "xpra" do
  arch arm: "arm64", intel: "x86_64"

  version "6.4.2,1"
  sha256 arm:   "b4b51c606cd749d93d664b081f9e48f86d1e86a155caa7b8e3f55c16dbcd590e",
         intel: "b59119b255c615fcc2077c2154ca47646c7726d0a5142f4b12a8ca4c6b4a1640"

  url "https://xpra.org/dists/MacOS/#{arch}/Xpra-#{arch}-#{version.csv.first}-r#{version.csv.second}.dmg",
      verified: "xpra.org/"
  name "Xpra"
  desc "Screen and application forwarding system"
  homepage "https://github.com/Xpra-org/xpra/"

  livecheck do
    url "https://xpra.org/dists/MacOS/#{arch}/"
    regex(/href=.*?Xpra-#{arch}[._-]v?(\d+(?:\.\d+)+)(?:[._-]r(\d+))?\.dmg/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map do |match|
        match[1] ? "#{match[0]},#{match[1]}" : match[0]
      end
    end
  end

  depends_on macos: ">= :monterey"

  app "Xpra.app"

  shimscript = "#{HOMEBREW_PREFIX}/bin/xpra"

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

  preflight do
  File.delete shimscript if File.exist? shimscript
  end

  zap delete: "/Library/Application Support/Xpra",
      trash:  [
        "~/Library/Application Support/Xpra",
        "~/Library/Saved Application State/org.xpra.xpra.savedState",
      ]
end
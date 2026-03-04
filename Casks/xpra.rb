cask "xpra" do
  arch arm: "arm64"

  version "6.4.3,0"
  sha256 arm: "644f581b43958351673d80e4e31e2261dec5ead999964121a1131af011b62d18"

  revision_suffix = version.csv.second.present? ? "-r#{version.csv.second}" : ""
  url "https://xpra.org/dists/MacOS/#{arch}/Xpra-#{arch}-#{version.csv.first}#{revision_suffix}.dmg"
  name "Xpra"
  desc "Screen and application forwarding system"
  homepage "https://xpra.org/"

  livecheck do
    url "https://github.com/Xpra-org/xpra"
    strategy :github_latest do |json, _regex|
      version = json["tag_name"]&.sub(/\Av/i, "")
      next if version.blank?

      "#{version},0"
    end
  end

  depends_on macos: ">= :monterey"

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

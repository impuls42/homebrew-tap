cask "sdrangel" do
  version "7.23.0"
  sha256 arm:   "d8599a55d5708b30231d91a11d45e7e187286abad56fcb5ef54ffc0c52864743",
         intel: "073a3f4f1469278d7f7e452ec415cfe9c17bf4c6bc54a4b4ffcb52fea0032be2"

  on_arm do
    url "https://github.com/f4exb/sdrangel/releases/download/v#{version}/sdrangel-#{version}_mac-14.8.3_arm64.dmg",
        verified: "github.com/f4exb/sdrangel/"
  end
  on_intel do
    url "https://github.com/f4exb/sdrangel/releases/download/v#{version}/sdrangel-#{version}_mac-15.7.3_x86_64.dmg",
        verified: "github.com/f4exb/sdrangel/"
  end

  name "SDRangel"
  desc "SDR Rx/Tx software for Airspy, BladeRF, HackRF, LimeSDR, RTL-SDR"
  homepage "https://www.sdrangel.org/"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: ">= :monterey"

  app "SDRangel.app"

  postflight do
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/SDRangel.app"]
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SDRangel.app"]
  end

  zap trash: [
    "~/Library/Application Support/sdrangel",
    "~/Library/Logs/SDRangel",
  ]
end

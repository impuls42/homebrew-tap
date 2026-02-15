cask "sdrangel" do
  version "7.23.2"
  sha256 arm:   "244f2e12dd079ec96ff16d469b586df942d2d05320ea12d109ada2ba6297174a",
         intel: "aec92c135f89216df02349ba3411f9be12c0aff2fc54251871652e3515a3db19"

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

  depends_on macos: ">= :sonoma"

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

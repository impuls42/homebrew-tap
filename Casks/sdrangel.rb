cask "sdrangel" do
  version "7.24.0,14.8.4,15.7.5"
  sha256 arm:   "61e08d28ed7540c20539dbfa5a3dd7ecb7e35309ba9babc659cf58473b34c1af",
         intel: "31d6bc6cd7375826cdaaccc76317e43749c7f6a6ca1368bf9ce65105775d7c94"

  on_arm do
    url "https://github.com/f4exb/sdrangel/releases/download/v#{version.csv.first}/sdrangel-#{version.csv.first}_mac-#{version.csv.second}_arm64.dmg",
        verified: "github.com/f4exb/sdrangel/"
  end
  on_intel do
    url "https://github.com/f4exb/sdrangel/releases/download/v#{version.csv.first}/sdrangel-#{version.csv.first}_mac-#{version.csv.third}_x86_64.dmg",
        verified: "github.com/f4exb/sdrangel/"
  end

  name "SDRangel"
  desc "SDR Rx/Tx software for Airspy, BladeRF, HackRF, LimeSDR, RTL-SDR"
  homepage "https://www.sdrangel.org/"

  livecheck do
    url "https://api.github.com/repos/f4exb/sdrangel/releases/latest"
    strategy :json do |json|
      next unless json["tag_name"] && json["assets"]

      app_version = json["tag_name"].delete_prefix("v")
      arm_asset = json["assets"].find { |a| a["name"].match?(/arm64\.dmg$/) }
      intel_asset = json["assets"].find { |a| a["name"].match?(/x86_64\.dmg$/) }
      next unless arm_asset && intel_asset

      arm_mac = arm_asset["name"][/_mac-(\d+\.\d+\.\d+)_arm64/, 1]
      intel_mac = intel_asset["name"][/_mac-(\d+\.\d+\.\d+)_x86_64/, 1]
      next unless arm_mac && intel_mac

      "#{app_version},#{arm_mac},#{intel_mac}"
    end
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

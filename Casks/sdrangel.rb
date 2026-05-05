cask "sdrangel" do
  version "7.25.0,14.8.5,15.7.5"
  sha256 arm:   "47f94d3a1e97eb8437460891850959a591e2f50298bfea6835e4dbf30f52eb1c",
         intel: "57252af26bbfee6fec21a47f4f89a59dc820922dd7a468a750ed90655be63320"

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
    url "https://github.com/f4exb/sdrangel"
    strategy :github_latest do |json, _regex|
      next unless json["tag_name"]
      next unless json["assets"]

      app_version = json["tag_name"].delete_prefix("v")
      arm_asset = json["assets"].find { |a| a["name"].match?(/arm64\.dmg$/) }
      intel_asset = json["assets"].find { |a| a["name"].match?(/x86_64\.dmg$/) }
      next unless arm_asset
      next unless intel_asset

      arm_mac = arm_asset["name"][/_mac-(\d+\.\d+\.\d+)_arm64/, 1]
      intel_mac = intel_asset["name"][/_mac-(\d+\.\d+\.\d+)_x86_64/, 1]
      next unless arm_mac
      next unless intel_mac

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

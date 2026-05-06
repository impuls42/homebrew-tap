cask "sdrangel" do
  version "7.25.1,14.8.5,15.7.5"
  sha256 arm:   "08faf0ae91d3343dc8809366e464a84f0af6bf7152beba0124e654d4a65d2272",
         intel: "b2f64072c48903e03b58b1c78ca9ee47d2a84884fd7640bfc01ea3a9eb006e4a"

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

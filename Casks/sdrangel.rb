cask "sdrangel" do
  version "7.27.2,14.8.7,15.7.7"
  sha256 arm:   "54a1888e3844565a384416c3b9e700ff1138749d42aff308c0da5caaeba01524",
         intel: "c454b306a46e253748568e2fc5002a3c886f0d48cfa0db84d364c13369b8d253"

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
    url "https://github.com/f4exb/sdrangel/releases"
    strategy :github_releases do |json, _regex|
      # The macOS DMGs embed their own app version and macOS build number, e.g.
      # "sdrangel-7.25.1_mac-14.8.5_arm64.dmg". Upstream sometimes tags a new
      # release while reusing the previous mac DMGs (so the embedded app version
      # lags the tag) or ships a release with no mac DMGs at all. The cask URL
      # derives the release tag from the app version, so scan releases and only
      # accept ones where a mac DMG matching the tag has actually shipped
      # (embedded app version == tag), otherwise the constructed URL would 404.
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]
        next unless release["tag_name"]
        next unless release["assets"]

        tag_version = release["tag_name"].delete_prefix("v")
        arm_asset = release["assets"].find { |a| a["name"].match?(/_mac-.*arm64\.dmg$/) }
        intel_asset = release["assets"].find { |a| a["name"].match?(/_mac-.*x86_64\.dmg$/) }
        next unless arm_asset
        next unless intel_asset

        arm_match = arm_asset["name"].match(/sdrangel-(\d+\.\d+\.\d+)_mac-(\d+\.\d+\.\d+)_arm64/)
        intel_match = intel_asset["name"].match(/sdrangel-(\d+\.\d+\.\d+)_mac-(\d+\.\d+\.\d+)_x86_64/)
        next unless arm_match
        next unless intel_match
        next if arm_match[1] != tag_version

        "#{arm_match[1]},#{arm_match[2]},#{intel_match[2]}"
      end
    end
  end

  depends_on macos: :sonoma

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

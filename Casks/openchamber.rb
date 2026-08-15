cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.18.4"
  sha256 arm:   "412372c3630e61ac0cc07d671b17b91f3bb2aeee7776fb073fed9fa936748edc",
         intel: "193adb6772fe116e1e64be1975d00f5b39b838ff20b041cf314f01e92b05073d"

  url "https://github.com/openchamber/openchamber/releases/download/v#{version}/OpenChamber-#{version}-mac-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/openchamber/openchamber"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :monterey

  app "OpenChamber.app"

  zap trash: [
    "~/.config/openchamber",
    "~/Library/Caches/ai.opencode.openchamber/",
    "~/Library/WebKit/ai.opencode.openchamber/",
  ]
end

cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.6.1"
  sha256 arm:   "d45189b18693f281419850708d5dedc286a9c291dece23267ea14d4f3a31fad4",
         intel: "5c6da244d0ea6ffcddcd1ae35f92a20fa44e4822f1aafd535694bd3a11aa2860"

  url "https://github.com/openchamber/openchamber/releases/download/v#{version}/OpenChamber-#{version}-mac-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/openchamber/openchamber"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :ventura

  app "OpenChamber.app"

  zap trash: [
    "~/.config/openchamber",
    "~/Library/Caches/ai.opencode.openchamber/",
    "~/Library/WebKit/ai.opencode.openchamber/",
  ]
end

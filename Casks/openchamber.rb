cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.0.1"
  sha256 arm:   "1566116f7f417c5916b7a13dcaaf6f34e9d7298ee74aedebd051854288b2aa96",
         intel: "993f1879a7bb45ce657e388652e7028bbd5f87617dca8eb68fc09b1585235db0"

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

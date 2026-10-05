cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.1.1"
  sha256 arm:   "b9851a84362f5738d5def429c362f8b6c048224882908224a83cdc48cc3ec21a",
         intel: "192f7279c0ddce3617c5d8167e393025d0223364838d26b9c2a8a6d61913098f"

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

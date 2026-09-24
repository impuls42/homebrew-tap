cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.0.0"
  sha256 arm:   "c30185ce2030acaec5b50283c4e8f2ef25588b07a7a81949e0a8ef8565aed340",
         intel: "28083f698f9bbf0d783f2dc29a2e3ef2d62dc3847e3e1c223d0f7b7a7a92e24f"

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

cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.23.1"
  sha256 arm:   "27f91ea748adf959d7881a22305b4dfb3d036fa7b636c309424ea395a912e7b0",
         intel: "9575027e2d6a5e1bd45d9a8ca503e40097db28c987969fa0157e7924afcdc4c1"

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

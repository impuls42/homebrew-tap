cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.20.0"
  sha256 arm:   "af5630ac3e1bf1c47e53357b39c055c8a2fe7b26c8627decc4e6bea4c9777634",
         intel: "2830b9c9dcdf32d915c43471423beb1a24e986c8f48343ac5d81d1323747da67"

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

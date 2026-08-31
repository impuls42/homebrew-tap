cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.22.0"
  sha256 arm:   "db8e4c2c999111aa7014238b2c3261c9ff0a2b644137c6d5bb3d1b3b0bbb6732",
         intel: "ab68585c4d9e4ae2ff409b0fffb737736464c3faf7b7f3e4f2d6e5402a07954f"

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

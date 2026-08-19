cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.19.0"
  sha256 arm:   "e7242f87ba7c25ab112825b985653f569fe8fe437b56736f82709f4f48d193ca",
         intel: "5f701c3fc50b686720759e73550b6af592ea9eeccc85812ad653c7c1d61c33ab"

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

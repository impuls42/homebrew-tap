cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.0.3"
  sha256 arm:   "7ee59cfc54137a1d970757586c12810944a8591155af87d1a9c12f0352481848",
         intel: "45364e0bb9465e31369db608d4e4cf35bf24b6996cf3c53677dcbe56e6401a08"

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

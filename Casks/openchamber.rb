cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.24.0"
  sha256 arm:   "01765bbf4134ca13360b9e65197d65f910c95d8b0f1a530e4c8d8fc965adaf26",
         intel: "e23910e19653e2b2471534be441bca391678b242c9dbc54c232118a5735aa120"

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

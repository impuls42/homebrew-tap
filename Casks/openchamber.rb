cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.18.2"
  sha256 arm:   "2c75dee9c21d690f7c0ebc71bc22361f7002c640c2a2ea1d8f7502c0fdd8d598",
         intel: "bf85daee7a192b782da6db847bab77acdafd12421b577c689b6f3e56b683e8a2"

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

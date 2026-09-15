cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.23.2"
  sha256 arm:   "371ba79c6cdd541cdce74635cf6c7a2f3429fa7afc80e0377379e172b6f0184c",
         intel: "5a1538b33dbe819d4207df491ba1b17c1245f6c60e8d0e221e97fb5a70ade391"

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

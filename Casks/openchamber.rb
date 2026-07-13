cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.16.0"
  sha256 arm:   "c80bb8c1378b842f6a73c0cfb7940680483b40ed2bc20f907ce677520c092cd4",
         intel: "2053268461690a55268634dfd4697b327b8cff003bba19ede7c48d1f102ac995"

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

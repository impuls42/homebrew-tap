cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.13.0"
  sha256 arm:   "f812cf77a16c9c26f31d4df3055911ae24effa940e033515749aa105baa489a5",
         intel: "38fb21a8c8877ad5e379b4b201bf840ccdf031b570595ce95838ae03ad7c6c57"

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

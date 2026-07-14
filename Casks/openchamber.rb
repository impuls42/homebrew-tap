cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.16.1"
  sha256 arm:   "3c6ad74e2ce880764c70acfb64e0ee864fd55831016d80b65fcf72584e24835e",
         intel: "fb265e86347f4eadbd539847ed39e5c7fcfd3ae846d76ab770c10c0647f3167b"

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

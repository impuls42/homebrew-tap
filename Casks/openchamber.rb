cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.15.0"
  sha256 arm:   "9123528384ca33a3823c7016865268a0a6898307cac12ffaa7800f20ab5ceaf6",
         intel: "aaa715a08c097caa6ee2e45c0ee997e4d62f9e4b8f10cd837d1175c701e1853e"

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

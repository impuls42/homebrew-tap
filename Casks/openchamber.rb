cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.16.2"
  sha256 arm:   "086c6f2e922d91e2bb45c3609c7c9268fcd7779e00869af4a519071b5e545c4b",
         intel: "d49e28931bd9b16b7dc6121d58129c91a6aa9686dddd9b836bdc89bf187fee8c"

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

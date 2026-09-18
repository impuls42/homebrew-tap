cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.24.1"
  sha256 arm:   "cf1353d4e59b1317f9bba8035b4087edf6d93ad9c95b1a8d41095a4c2fe87dc9",
         intel: "2bad648aa97e28bc61b26ca31536bfef8836f78baf86f762b29dbc5c75010e9a"

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

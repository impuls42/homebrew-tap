cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.6.0"
  sha256 arm:   "2741c8c548530e68cf8e28720bdeecbbb1fa11df72e3d14e79c848845021282d",
         intel: "d91e076faf2c9ad1821b0ce302bc2a4fdc775eadae70da217e136647ca735b52"

  url "https://github.com/openchamber/openchamber/releases/download/v#{version}/OpenChamber-#{version}-mac-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/openchamber/openchamber"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :ventura

  app "OpenChamber.app"

  zap trash: [
    "~/.config/openchamber",
    "~/Library/Caches/ai.opencode.openchamber/",
    "~/Library/WebKit/ai.opencode.openchamber/",
  ]
end

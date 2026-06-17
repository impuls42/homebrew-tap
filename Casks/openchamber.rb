cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.13.1"
  sha256 arm:   "f79d5f92b2b9122f020b36bf896f3971c704d851a6d1b84400c8a41daeec2cc7",
         intel: "c50415cafd523c1418589772290cccbcf23c5917d11278e14b56bfe1cb4a9e84"

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

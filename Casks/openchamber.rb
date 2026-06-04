cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.12.1"
  sha256 arm:   "f167a438d5e588c7cbb94c06441be0a7b7a8a02444ab380ef8908dfc51bcbd0e",
         intel: "091fb5092d6692b6eab950a77db1f4b92f18d3df6d16af819e9db06fc3bcf3fb"

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

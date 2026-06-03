cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.12.0"
  sha256 arm:   "b3ef718ac63ae40ab1e310116d1a1ad75dec1f4dfa8f4f6c55be142269cc02bb",
         intel: "2f7aa55711dc8014d457ff1a7dc2b90cb2bc10123c5d93d9912133ea83e8a580"

  url "https://github.com/openchamber/openchamber/releases/download/v#{version}/OpenChamber-#{version}-mac-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/openchamber/openchamber"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: ">= :monterey"

  app "OpenChamber.app"

  zap trash: [
    "~/.config/openchamber",
    "~/Library/Caches/ai.opencode.openchamber/",
    "~/Library/WebKit/ai.opencode.openchamber/",
  ]
end

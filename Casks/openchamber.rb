cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.17.1"
  sha256 arm:   "bfe72404d1516890ecf2867cb11a56f9feb33b746bf122f0e7605116353d2980",
         intel: "c4976dc04c143fb02f6e7c4be131003090d3f8a701974b575ab9c4b4f4fd714b"

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

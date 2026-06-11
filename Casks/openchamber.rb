cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.12.4"
  sha256 arm:   "34a8b3e3250f4ff51d3c6c01ad2cd1eca62022a6a9e595fd67a8ea2bd3f0d921",
         intel: "84514288c9d07abdd704b61c74f4343380f1d4c6feb359161e69ff8877fc1726"

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

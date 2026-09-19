cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.24.2"
  sha256 arm:   "66c3ff59ab6dc289c7f7a24e7bd902bc73d0387030d0395fd9e55bc1beb73f98",
         intel: "afed05b0db3019cfaa3b5b7d4ee5e249e758b95572f7b0786cfb6e7df4b517ae"

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

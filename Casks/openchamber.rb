cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.3.2"
  sha256 arm:   "c94c641e086279363fb68222f93584344c1e4a4a73263de3c3cfacc3ffd0231e",
         intel: "817f47ea359375070f78af609126f69f9132ea21d283a92f64464f950226ac85"

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

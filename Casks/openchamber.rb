cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.8.0"
  sha256 arm:   "336ca3514797568cd54a37343777e2d2a7ffdfb4abd18569afcd36fb45fc3ae9",
         intel: "4fb5c840c853a3d623fd538acb5cf6b161dce60f127628a264fa8b12c1597c8f"

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

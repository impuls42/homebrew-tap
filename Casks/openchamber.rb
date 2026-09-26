cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.0.2"
  sha256 arm:   "c646625f1c45bf3649babbdd1da6ba972a2cd835c53ff6bb99e354c6795c73df",
         intel: "24c538231fdfaaa535f6fe5d50651885669e5ab72134b70072e65060c794f63c"

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

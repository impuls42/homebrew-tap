cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.5.3"
  sha256 arm:   "d41849339b3db9aa229016fb46d12428bf644e1c7631c16ae919f50b1d137ac4",
         intel: "c6a3420aa11e4f3fae8b3aefdb21d58be20ddcbb47e2da6e678a6b1466e9fe81"

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

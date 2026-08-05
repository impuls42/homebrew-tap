cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.18.1"
  sha256 arm:   "8a0bea0461ebdf6d3bd8443bb58bacaa8e017733f5689e6de6aa5a0d2a0013d1",
         intel: "1f94f113d933c3493ecbe394c3fed5426210bda555587b392ab5b283bbf82530"

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

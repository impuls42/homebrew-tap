cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.12.3"
  sha256 arm:   "82e167615b3b2325cff4f2728c8ac3c0378455bcba97d8c14a24a2523bfba463",
         intel: "36ab67bccf7ccce1054c528c29c96aca5bdba0afbff1e2ddd1e402be2b8b8563"

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

cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.21.0"
  sha256 arm:   "0d1b4218ef3edf05c8cbf16fcc606b29f1cab8c2d110434f5088cf7e16558949",
         intel: "ce69b643bfee84dcc2878c9aa0c01c1c3002661fb47c6759876327d89ca9c2c8"

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

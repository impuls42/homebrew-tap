cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.13.3"
  sha256 arm:   "adc8aaa46ade7c2b98bede10423ef82a4c9b29fb74834f352b37cc8db2c5337f",
         intel: "f9af8438547327290735dc801a2981031247775324fbe397cffb4a5df0ff6d95"

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

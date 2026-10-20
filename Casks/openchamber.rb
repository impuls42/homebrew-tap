cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.5.0"
  sha256 arm:   "fc950086015449bc1beb32f33f4c4bffce2d62cd66065c594bfb25d9b2e6eee2",
         intel: "fe9fc0a5335ec10d5abd5e79cd30cc274056eeabf02066615c20db648ca1077f"

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

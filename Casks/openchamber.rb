cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.18.3"
  sha256 arm:   "2733d4340f9d136d1923f106b452a5a2b0e1874a5e40a3565ba3d0380ed0dd5c",
         intel: "2b01f85aff65ba925631ee4d7d4e320a7d2a037f82284f42647bbd19f0b41b27"

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

cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.0.4"
  sha256 arm:   "0dbee56570ce8c6e6f0b0c9e9c6479e921802e3b053d5284152a985b2d3d8896",
         intel: "a494a90274b0bdefc4a0a412bc2269957dff8dd206227b686b60fd098fc1ef7d"

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

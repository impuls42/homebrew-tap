cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.14.0"
  sha256 arm:   "da9dedef88b482fa1a2abd993f5e05e9009b63938679f3ca3e49011b12c1a145",
         intel: "21d5163a6cff729025ade7bc8e29539266b896a70ff4180a859405d6f11f0b96"

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

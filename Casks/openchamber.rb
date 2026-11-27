cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.8.1"
  sha256 arm:   "9cfa5aebfb8a5e643e7c4856f9685b784cd430d2d20e376aaccb79b6130a3217",
         intel: "dc213e399dcb24ea37885103d3592dddaa7c30c620a22310f595e12b75ad3e84"

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

cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.5.1"
  sha256 arm:   "229a767da5695d5820ede21c6582740ad77cc08bcf0f84bc29bc5450b4a8ac1a",
         intel: "6a2cdae7c9f4e75d9c8701ba072c2740b3bd3c2cdd4f75d34da2299d453bc753"

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

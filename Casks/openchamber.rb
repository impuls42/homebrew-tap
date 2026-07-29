cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.17.0"
  sha256 arm:   "667a700eaa8472c239f9ee3dbeb80bc6d648a3cd8a1ea58194dc9e2cd148ee1d",
         intel: "c2ae3c91c68c19a996d632c265db2b72ac543021f8e23fe2ce67caee86769e03"

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

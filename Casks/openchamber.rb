cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.4.0"
  sha256 arm:   "b600d4500ab5ef973bbc2901ebcc7e6d699ad0e6dd61fc4780481978aaf3275a",
         intel: "979dfdf7fb280868794a508bb50f2ac4978071d35109fa2c670db65f90f195ac"

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

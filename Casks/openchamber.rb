cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.7.0"
  sha256 arm:   "4fe4af4b736e978dd5dffe1b4e1eeabcbccd30a82d906cdf842861b1ad0042af",
         intel: "fee6ffae4d6d2c05aec0b97548fbf6348e6ea23467c7a54b045c671d0e7f4adf"

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

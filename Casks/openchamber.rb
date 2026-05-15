cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.11.0"
  sha256 arm:   "d736a4cececd5784d312d55574d7dc939a7f4996f00d950aa57cec5c61f4205f",
         intel: "35e0e27a7aeec5a8ce86172682d467ce2e08bdce49c2a94c3509a68535bb169c"

  url "https://github.com/btriapitsyn/openchamber/releases/download/v#{version}/OpenChamber_#{version}_darwin-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/btriapitsyn/openchamber"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: ">= :ventura"

  app "OpenChamber.app"

  zap trash: [
    "~/.config/openchamber",
    "~/Library/Caches/ai.opencode.openchamber/",
    "~/Library/WebKit/ai.opencode.openchamber/",
  ]
end

cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.10.4"
  sha256 arm:   "ed03896697d71a8f3aec9692ae098d320751fa7b8336617cab5846f15e110e16",
         intel: "3284b68d90ceca73209c8d0c8dce7f7988cfdad9c26b18284b43852cdff660cd"

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

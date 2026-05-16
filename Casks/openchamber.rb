cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.11.1"
  sha256 arm:   "cc244acd4f99e0f8a00098d5d80cadfeef053e207b83694a93cdbfe4358adbf7",
         intel: "f5a9ebdf77f81be2d161ea0915fb284b9785a7c1744eff28efdb6dc49639add6"

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

cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.8.6"
  sha256 arm:   "5578d6de3050d090eda0d3def72b9f9297621d87413a8365db3ea9fb92f1be48",
         intel: "9f49ba7d5d37bf96ed76477bb82c1480dd39e07cad26fd2f44b5d8c6dbcbb4cd"

  url "https://github.com/btriapitsyn/openchamber/releases/download/v#{version}/OpenChamber_#{version}_darwin-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/btriapitsyn/openchamber"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: ">= :sonoma"

  app "OpenChamber.app"

  zap trash: [
    "~/Library/Application Support/OpenChamber",
    "~/Library/Logs/OpenChamber",
  ]
end

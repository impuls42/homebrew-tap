cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.8.5"
  sha256 arm:   "fed7a0d3eb22ad220d506cdf8c06f6eb1977060f6cc1b88472bd4fe86528cee3",
         intel: "515b0f58501c6d714c1c1ea75e004950b86687661e36368b1bd52c71e90eec1a"

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

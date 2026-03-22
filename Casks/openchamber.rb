cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.1"
  sha256 arm:   "bbbdc5829597054d811f09c0e10067354464723885ee66a33baf4336395fbe5c",
         intel: "68b854570941f16d22f42c1cf6e80ed827497165b3beef104d505fb6cd7bd113"

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
    "~/Library/Application Support/OpenChamber",
    "~/Library/Logs/OpenChamber",
  ]
end

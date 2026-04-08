cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.4"
  sha256 arm:   "3067f0d60d74cb3efbbc783909f58672c3d3df8116b005722c34e3a005ebe4f0",
         intel: "8f94c2d9b7dafaedb2efa2ec7d3ff967c8228a88e71d2db803aab3ca8f10b616"

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

cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.10.2"
  sha256 arm:   "4fd393898de7999e2657b28dcd827f2029ceaa219ae5934a558e43220b3a7e7b",
         intel: "e1be812e8c8da97ee95aa270cb5ebd871ec81f71c74f7e85743f66abd5e86496"

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

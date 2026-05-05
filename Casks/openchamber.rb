cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.10.0"
  sha256 arm:   "6199e919025095a3320699c64694910d68911b9b133657b7cafe1fbb9cb86824",
         intel: "935a7a72beeb90b8f1cea98b3185b280b20acca06ac78f591308102ca45bb807"

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

cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.10.1"
  sha256 arm:   "b1ba0ad20377e4429bc7fe892ed94feaa5701511aa021b82d156332c97f00499",
         intel: "6cec7a88887c0ef0090cbd0b08cd73dc66abe6f9f4f09a3de1e3ad8d48bdbe65"

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

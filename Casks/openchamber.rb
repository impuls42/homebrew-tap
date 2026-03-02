cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.8.3"
  sha256 arm:   "e3fe1a1db7c993c7f7aebb588f457733aaaaf47aee85ca735fc2de8a34062a04",
         intel: "a923b55d6ad9c50f6366f84ba141af137e14dc9fa8bdc2194cb4d34f0d9f2cff"

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

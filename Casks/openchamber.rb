cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.9"
  sha256 arm:   "1a45ea8d10462a80d2cd7a6c15d238c2c1efd62cd81a63e6128469894ae77826",
         intel: "64e2f4f5f6ba0236219868025356e8e93a0c20ae3b57cce4ee1483d6d865e13a"

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

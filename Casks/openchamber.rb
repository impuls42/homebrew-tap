cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.2"
  sha256 arm:   "aa6a32265eef0ab355fad45fd2b3c0f244d09946682b0c4d63f61b57bce2e9cc",
         intel: "b9483116a8e8f3a16cfa2bf827852aa9780b3fbd6a6677ec9c0282656cf2a5c8"

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

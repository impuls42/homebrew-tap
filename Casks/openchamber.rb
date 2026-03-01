cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.7.5"
  sha256 arm:   "8751b6fae8649e056149ef7af93047e4cd14e8f5ffde3e68e350ca4362b91ae7",
         intel: "5b9d97e0b1e524274527dd972bd2c7b3451fd93c744c3937446becb915dc1f46"

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

cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.8.4"
  sha256 arm:   "9e19599be72057f5bed1c9a96b19ad34930da706ddf2b4ae6906047f7959c7a5",
         intel: "7ebccf09d351ae605557054219221244815c6b430fb5ffb1ac7a877e9377bf53"

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

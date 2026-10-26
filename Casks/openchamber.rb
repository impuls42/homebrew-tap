cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.5.2"
  sha256 arm:   "6da9e5e306f00e5b381d72849f0096ef59d9521ed0d591bdf4ab28ea5b690872",
         intel: "7d186f5ec78da66499b8d74c88a23b6bca172ab21c15d2f7ec85ab63ea6c5bf8"

  url "https://github.com/openchamber/openchamber/releases/download/v#{version}/OpenChamber-#{version}-mac-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/openchamber/openchamber"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :ventura

  app "OpenChamber.app"

  zap trash: [
    "~/.config/openchamber",
    "~/Library/Caches/ai.opencode.openchamber/",
    "~/Library/WebKit/ai.opencode.openchamber/",
  ]
end

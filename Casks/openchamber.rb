cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.8.7"
  sha256 arm:   "7f14c120ff02cf8fe1289083142e1ad403ec7ac2b7863e276dae379f55f2f40f",
         intel: "c51667124e265ec9002d3eac482f5f2ba8a5cb5ba494bf3cfd619cc99a8695da"

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

cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.14.1"
  sha256 arm:   "8e68e463f7d85bcd325fefceab27f07edf20d44246772a3161fdbe5d199d582e",
         intel: "b466f07a3494d599d53542715738e10402a88a7c1cee122cc9b98b881d67d388"

  url "https://github.com/openchamber/openchamber/releases/download/v#{version}/OpenChamber-#{version}-mac-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/openchamber/openchamber"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :monterey

  app "OpenChamber.app"

  zap trash: [
    "~/.config/openchamber",
    "~/Library/Caches/ai.opencode.openchamber/",
    "~/Library/WebKit/ai.opencode.openchamber/",
  ]
end

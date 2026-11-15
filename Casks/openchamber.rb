cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.7.2"
  sha256 arm:   "682699251cee5f9a3c6132db73db2e91543f402dabe0172c6babac752408cd32",
         intel: "24131fc0bc41cf549d4ce2e81cfaf050b7dfc448a40b44e9b2ff67fc8998278b"

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

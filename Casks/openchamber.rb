cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.7.1"
  sha256 arm:   "896315f55dde15519676f2c96872aef689d4ca10b9a2fff9c26a10a8dca5361e",
         intel: "c3ab49ab1b7b9d5a30e6985fefefba814b469c9b653e7e56217cc6d5b246c79d"

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

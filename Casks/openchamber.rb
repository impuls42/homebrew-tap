cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.13.6"
  sha256 arm:   "f41999ab96f84f3df08dc95f003044eef1f3991d9078354ba8c5b8bf50dc7f1f",
         intel: "a1a3d032b5f6c5fc8aedc3246e5dae62c2a74ddda6a5d6039b1de6add5659e4b"

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

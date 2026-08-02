cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.17.2"
  sha256 arm:   "f5db42f3cfc1101022e221db0601c2faebbde8faf0c23430a17eaaf436489072",
         intel: "76c9b5f78e99f199f166fb82c1c7bdc8adc9438c1db9d1e7dc1cf24594a65f19"

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

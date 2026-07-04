cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.13.9"
  sha256 arm:   "ec19c13e7a11506ac08f965a153f9177d3b60fe3dda0b195d7ae210c0dc0c92b",
         intel: "9e88a9dcfca1ca8882a612afe919a174adebd5568dbf2eaf57af7d1571684cac"

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

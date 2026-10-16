cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.3.3"
  sha256 arm:   "4e3d779a18455dd8c27df142523d8312df760744781dea5a9691724d72164c09",
         intel: "6fc335d15b807ba7bf64fe00fede9e6fe2cb6b5b66b2cbcbc0940a5cf8c6cc55"

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

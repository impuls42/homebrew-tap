cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.21.1"
  sha256 arm:   "377da6c6665f02c99f007d2c4ae84bdea6d88a2548e271c1a2002ea77f4772e2",
         intel: "3ef80038583169b0b49c4318363254633073a2395273bacce4f99c60fbcab232"

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

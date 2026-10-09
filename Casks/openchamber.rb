cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.2.0"
  sha256 arm:   "c5d194f0b4b993e3a35f0cbbe407e99cb7fd0299840bb8aa8fcaceca6c7d2263",
         intel: "c81224bdde4ff156ba12745d5bc315df1e723ad72d85bd0641af864b9805aaa9"

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

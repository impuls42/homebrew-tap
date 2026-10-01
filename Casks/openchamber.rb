cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.1.0"
  sha256 arm:   "e16f04d0b94970c1b0272c705543c6f23fe307062b119c66924d6958aaf5cbf8",
         intel: "dde9a2f4f3fbea9658b0647eb8124a3ce965143c82af846902f703f4efd1d559"

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

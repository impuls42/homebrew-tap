cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.23.0"
  sha256 arm:   "4029f2344875fe1ab69d2cbcbd9f58cd17457c640d8c6da05f3e6668f5e12895",
         intel: "a11df642c4acb285f66985c3afa3a05e72a7e23d7f66afc626548d30523f6f62"

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

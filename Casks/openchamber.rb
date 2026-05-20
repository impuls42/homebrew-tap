cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.11.3"
  sha256 arm:   "a7a05af11c14d9e61fe74d922acf3af4bb6d559d4cf2f17ac880e95b539869d2",
         intel: "758bc02f92209b684956e7038d10886f322207e44916018199da199f61d5c1e7"

  url "https://github.com/btriapitsyn/openchamber/releases/download/v#{version}/OpenChamber_#{version}_darwin-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/btriapitsyn/openchamber"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: ">= :ventura"

  app "OpenChamber.app"

  zap trash: [
    "~/.config/openchamber",
    "~/Library/Caches/ai.opencode.openchamber/",
    "~/Library/WebKit/ai.opencode.openchamber/",
  ]
end

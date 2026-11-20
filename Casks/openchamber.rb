cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.7.3"
  sha256 arm:   "3b27250271aaeeba0b1841fdb3731e37b532d10738a84e972b77d5638ed3d2f7",
         intel: "c6d454adc2399625777f3d6eb02fedd741a34373b30b5be528ce75281af2bab4"

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

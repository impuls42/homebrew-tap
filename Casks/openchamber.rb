cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.11.7"
  sha256 arm:   "8f6d0e5a77c4adc654758681a4da7a5b0244abbc8b6821851b40066bafb7e7a2",
         intel: "48ab8587ea5e80226c7a34e1cb3fa72fd5d0b18a1065e82c7b734cc11591ecd8"

  url "https://github.com/openchamber/openchamber/releases/download/v#{version}/OpenChamber-#{version}-mac-#{arch}.dmg"
  name "OpenChamber"
  desc "Desktop and web interface for OpenCode AI agent"
  homepage "https://github.com/openchamber/openchamber"

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

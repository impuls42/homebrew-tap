cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.22.1"
  sha256 arm:   "5d7369ac1fa0dfdcc66cacb94300f2bbab07988686c1c48f8ebcac70a0117632",
         intel: "34fd2bf42372e08702de2f89d7dfa27287289c34deabfc5effb2f0279a7890d3"

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

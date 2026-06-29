cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "1.13.8"
  sha256 arm:   "3e7526d87e94b9fedb47a66b0558801df8c3cba2a1c7a2c9970ef0e8264f70ec",
         intel: "ee35443a3eb7913c94b0ec7c8ee500da0eb467e1808e620b7c9317ad1260a8ed"

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

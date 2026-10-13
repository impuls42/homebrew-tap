cask "openchamber" do
  arch arm: "arm64", intel: "x64"

  version "2.3.1"
  sha256 arm:   "d0f90c47700fa96d47f7b411ebbe046007eb896b0785e6613c1261b268db3298",
         intel: "62c0ef4ac0702465eebf0554f5e0ac78afcbc5556d026c19a0061d92bb1d5879"

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

cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.6"
  sha256 arm:   "bf48c64544e25d12fcb79d359b868c23c4de7c99a627d880bb2d2acd49224acc",
         intel: "87361f25b4e7eaff7bb4b1fbda46036d713991e26e530052085eb3fac5cfa36d"

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
    "~/Library/Application Support/OpenChamber",
    "~/Library/Logs/OpenChamber",
  ]
end

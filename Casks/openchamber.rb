cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.10"
  sha256 arm:   "8ff3193291a820a58611fed5095b7c800386cd9f141a490b22b09f10ae383400",
         intel: "974f5848471fdf443b9f4e3e31dee0a32d0c18f6e2c73f1db7ed480909f51ee5"

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

cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.7"
  sha256 arm:   "ad99676f1350324e8cd31e4e5bb870cf3667b2945accf4aed8b79a58784f0fa5",
         intel: "eedbb46600a9f047576c95c80d3ba5d62a78514267999dbe09c8b2405171b4a1"

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

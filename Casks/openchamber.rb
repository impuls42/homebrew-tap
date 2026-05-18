cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.11.2"
  sha256 arm:   "91f9eb9edc113fb54c75f83497d118f1caad57105286822727bf9e6b862916c1",
         intel: "27841a02de69541f05d3d86f37327d8a91d0f6f3cb6b08c0b7e6ec8e27210988"

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

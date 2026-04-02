cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.3"
  sha256 arm:   "8dd3fa5f8441967ba142d8ef3b0defcb29800d59567b99ddc9c10a010a964a2e",
         intel: "2ce458d9186876aa495dd8ecc60c656e83948f9ccd0501f90636d80a61541119"

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

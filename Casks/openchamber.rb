cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.8"
  sha256 arm:   "f965e38a404d86547d1f65c900c2427f727d72ba023bb2fb91e51974a80f52f3",
         intel: "032cf559fe824b1732842f53f9f6276cb2128c134da0dd85b08f764231374257"

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

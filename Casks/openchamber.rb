cask "openchamber" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.9.5"
  sha256 arm:   "80551d2143ddd6c83b3b16790c3dfefe52e1d5fbd14ba8e9caf88977b94de4ef",
         intel: "175ba5e7c99cca8aeab4085974b1b94e40dcdaac87e7fe21261d852f32e6cbcb"

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

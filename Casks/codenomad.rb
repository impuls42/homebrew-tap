cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "0.16.0"
  sha256 arm:   "a5ed5214e0eae569b4f9d0daa5d904afdf0486c8b5014e705a0a05eb5d5f4955",
         intel: "d396b3ddc94697929712b92c62f28c17976f84694b927eaaa412080b2ee4bb56"

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-Electron-macos-#{arch}-#{version}.zip"
  name "CodeNomad"
  desc "AI-powered coding assistant with remote development and sidecar support"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: "codenomad-tauri"
  depends_on macos: ">= :monterey"

  app "CodeNomad.app"

  zap trash: "~/Library/Application Support/@neuralnomads/codenomad-electron-app"
end

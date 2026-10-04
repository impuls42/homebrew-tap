cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "0.20.1"
  sha256 arm:   "7e8408f6d486d7406a2b686edae7e8acbd3f08e63df835e7ff5f4d1bce4c8055",
         intel: "e546379bb0b7e2df0fcafb71fe1f5ee6e35f44dbd3a1ebd51bead7f2a0907b94"

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-Electron-macos-#{arch}-#{version}.zip"
  name "CodeNomad"
  desc "AI-powered coding assistant with remote development and sidecar support"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: "codenomad-tauri"
  depends_on macos: :ventura

  app "CodeNomad.app"

  zap trash: "~/Library/Application Support/@neuralnomads/codenomad-electron-app"
end

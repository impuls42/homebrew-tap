cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "d3f12c086fc2c58bc3c91d07d8414fbb0fa57ee31bca88ff1a7f4f637a8d3570",
         intel: "f863f1cde7fd2fab4f03817ad51a9467d63c2c051b9c04f968e0b6dbfc9feed9"

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

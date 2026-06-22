cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "0.18.0"
  sha256 arm:   "332eaac0bac326f05e04617bc1a71167b71c9442859062668206353a83a435f0",
         intel: "9ab7b5c05b55b28c6ea832aeff10de107b9e96d5d06f97f45ca1cc46be1e8c47"

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-Electron-macos-#{arch}-#{version}.zip"
  name "CodeNomad"
  desc "AI-powered coding assistant with remote development and sidecar support"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: "codenomad-tauri"
  depends_on macos: :monterey

  app "CodeNomad.app"

  zap trash: "~/Library/Application Support/@neuralnomads/codenomad-electron-app"
end

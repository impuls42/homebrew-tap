cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "0.20.0"
  sha256 arm:   "bff50717e5d8fed2a81d2877978e877e6fe8fbbb3d8bb2ff502470218147d342",
         intel: "85ffe24e07a323272bfa079653832afd1eae01ac51a437d86796091991bd0821"

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

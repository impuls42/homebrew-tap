cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "1.0.1"
  sha256 arm:   "c0c59b0940a261b544fd081b1c0169bcabf4ca40b32007339b3c727d628d7929",
         intel: "c772a12917cb445ae8a5799c32effe8015bfd662a11ffbc157f1db58107584b8"

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

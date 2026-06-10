cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "0.17.0"
  sha256 arm:   "7fb990cd44f7154ecace9fffc2a06e0355aabe79d25ead1776a5fea959dd6669",
         intel: "d0bf3ab72451b560b3ec8b494eb406f955f0eacfdf72be20466a424492d17326"

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

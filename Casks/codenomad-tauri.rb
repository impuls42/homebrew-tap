cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "0.17.0"
  sha256 arm:   "052e51e078b2ce6642bc9000d96e1901e3795b2eb0438a7d171cd2d5198cf122",
         intel: "ed9457d4e6f20b0af60216ee0e1d281770314c528c37ba5270b7dd13e0d6c3cb"

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-Tauri-macos-#{arch}-#{version}.zip"
  name "CodeNomad Tauri"
  desc "Tauri-based desktop app for CodeNomad"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: "codenomad"
  depends_on macos: :catalina

  app "CodeNomad.app"

  zap trash: [
    "~/Library/Caches/ai.neuralnomads.codenomad.client",
    "~/Library/WebKit/ai.neuralnomads.codenomad.client",
  ]
end

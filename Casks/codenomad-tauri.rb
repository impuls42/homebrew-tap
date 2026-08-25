cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "0.19.0"
  sha256 arm:   "ce2d05e20686609ea38b8576bee4b4e8192b36ab1e4dff65f12a8c744598f8cc",
         intel: "d71a4dbe20ee13e40f8016cf9054312073275fafc86173f2bc2d9d4de2682a28"

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

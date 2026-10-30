cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "1.0.1"
  sha256 arm:   "d0fd05abfe5278e3574db1725a0a8d00653d71071cc8b9d939cca17e68f1f763",
         intel: "8294488626b3f2f7ea20a9ded503562194e75b85e22c251c3cae8c7e4b25bbd2"

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-Tauri-macos-#{arch}-#{version}.zip"
  name "CodeNomad Tauri"
  desc "Tauri-based desktop app for CodeNomad"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: "codenomad"
  depends_on macos: :ventura

  app "CodeNomad.app"

  zap trash: [
    "~/Library/Caches/ai.neuralnomads.codenomad.client",
    "~/Library/WebKit/ai.neuralnomads.codenomad.client",
  ]
end

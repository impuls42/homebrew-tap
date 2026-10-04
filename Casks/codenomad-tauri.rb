cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "0.20.1"
  sha256 arm:   "f25007502354a33c99d37a4e655f61055487db137702a331c685af8afd9784eb",
         intel: "1384842c5e38186dda26262cc8d5edb40d324d2fe6462cca648895ca16840014"

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

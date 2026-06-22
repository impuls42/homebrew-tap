cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "0.18.0"
  sha256 arm:   "e44cc8fa7bf5a8fffff7a6e346219e87490740dd7a80d4e635ca9ef0fb07106e",
         intel: "5bec27c472359f7f5f4f1d1a6f4ad206b723bfd9d4cb04c452fd9ec234099dcf"

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

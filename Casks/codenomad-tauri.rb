cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "388902a74a1bdbe4c59c42586f5c3c2e5e92c9b726e2a70921ce48a5d342af16",
         intel: "26862b9495db6626034451abe8c7521f09d7e91163e4a2f5f3f184e4494ad90c"

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

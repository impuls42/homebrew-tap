cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "1.1.0"
  sha256 arm:   "242949bfe9e78e6149c177f117a583536d83983369eff1daa625bbda52e414b6",
         intel: "422d835c2c0c40eeadae31f3f3c5906225e3fd21fe22deea587346c3321f4d02"

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-Tauri-macos-#{arch}-#{version}.zip"
  name "CodeNomad Tauri"
  desc "Tauri-based desktop app for CodeNomad"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: "codenomad"
  depends_on macos: :sonoma

  app "CodeNomad.app"

  zap trash: [
    "~/Library/Caches/ai.neuralnomads.codenomad.client",
    "~/Library/WebKit/ai.neuralnomads.codenomad.client",
  ]
end

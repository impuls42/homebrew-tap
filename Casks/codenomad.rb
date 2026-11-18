cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "1.1.0"
  sha256 arm:   "89ccfe53a8248381df471f5e42a20d8e92e334569196a561680d374d5661ebc9",
         intel: "bd42599d655a2c52c4dd3d6c74606603326f6d9b284acbafd7968d7be6c66fae"

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

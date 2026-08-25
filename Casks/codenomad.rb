cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "0.19.0"
  sha256 arm:   "107dd5c42609c34604c487169ceb271b1ce5eae5c0051dbaaf4247249cb4ef5b",
         intel: "23815b056b2e574dc1cc8f8f08674959a93ff16bc14ebab3d6621f572e5e9b46"

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

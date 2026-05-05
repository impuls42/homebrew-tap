cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "0.15.0"
  sha256 arm:   "68fcecbae9f753eb39f7a83c7f8dce8e3b7ac964004b35910b6ed41ea420bc10",
         intel: "c02ac6fbceae140cc51bdaaaf684277cb9844524cb8f5a3332bdb65e19257559"

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-#{version}-mac-#{arch}.zip"
  name "CodeNomad"
  desc "AI-powered coding assistant with remote development and sidecar support"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: "codenomad-tauri"
  depends_on macos: ">= :monterey"

  app "CodeNomad.app"

  zap trash: "~/Library/Application Support/@neuralnomads/codenomad-electron-app"
end

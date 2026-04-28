cask "codenomad" do
  arch arm: "arm64", intel: "x64"

  version "0.14.0"
  sha256 arm:   "931a9b1938e8cd8026baa1390a6c00d4b6aceb04c4026295e12f3ee629e4472c",
         intel: "9e90b12ed8d34b8ab0074d79cc80e21917b28fc2aabcad395f861ee31f916fc6"

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-#{version}-mac-#{arch}.zip"
  name "CodeNomad"
  desc "AI-powered coding assistant with remote development and sidecar support"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: "codenomad-tauri"
  depends_on macos: ">= :catalina"

  app "CodeNomad.app"

  zap trash: [
    "~/Library/Application Support/@neuralnomads/codenomad-electron-app"
  ]
end

cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "0.15.0"
  sha256 arm:   "0bfa5bc8353e5222c70ea575b2e38b77a83ba783046bc1c64de597eb597f85fa",
         intel: "4af1f8e1ee78d8a85c2d427d985432ffd733ff6a8ecf8aac8d7cfb4c036ab842"

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-Tauri-#{version}-macos-#{arch}.zip"
  name "CodeNomad Tauri"
  desc "Tauri-based desktop app for CodeNomad"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: "codenomad"
  depends_on macos: ">= :catalina"

  app "CodeNomad.app"

  zap trash: [
    "~/Library/Caches/ai.neuralnomads.codenomad.client",
    "~/Library/WebKit/ai.neuralnomads.codenomad.client",
  ]
end

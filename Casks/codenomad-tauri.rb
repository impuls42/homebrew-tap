cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "0.16.0"
  sha256 arm:   "42f828b8b7d3d84c62741f1b06aab32983f74df8c30c774bff96855a7879cf58",
         intel: "4776fae0306e6cf43b21b0aafc2446209be174ec954c85d3c7de95743ada313e"

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

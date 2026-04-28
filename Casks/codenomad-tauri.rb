cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "0.14.0"
  sha256 arm:   "0c51e1ff9d2b62eb3d0058a28dfc6c5de5b0a937c1bdcf063ad7bf7ca2bf1f19",
         intel: "565445de0a809a7a0827da4cf761931031fc49db31241469c132acacc854c578"

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

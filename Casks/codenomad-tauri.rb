cask "codenomad-tauri" do
  version "0.14.0"
  sha256 "0c51e1ff9d2b62eb3d0058a28dfc6c5de5b0a937c1bdcf063ad7bf7ca2bf1f19"

  on_intel do
    sha256 "565445de0a809a7a0827da4cf761931031fc49db31241469c132acacc854c578"
  end

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-Tauri-#{version}-macos-arm64.zip"
  name "CodeNomad Tauri"
  desc "Tauri-based desktop app for CodeNomad"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url "https://github.com/NeuralNomadsAI/CodeNomad/releases"
    strategy :github_releases
  end

  on_intel do
    url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-Tauri-#{version}-macos-x64.zip"
  end

  depends_on macos: ">= :catalina"

  app "CodeNomad.app"

  zap trash: [
    "~/Library/Application Support/ai.codenomad.CodeNomad-Tauri",
    "~/Library/Caches/ai.codenomad.CodeNomad-Tauri",
  ]
end
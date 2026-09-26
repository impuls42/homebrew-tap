cask "codenomad-tauri" do
  arch arm: "arm64", intel: "x64"

  version "0.20.0"
  sha256 arm:   "fabb83f4c2ebc11c0f12302382a11b6aa86a9312a492eaca09cc04dba5484ec9",
         intel: "6f9a478188a93453620b9cb015c68710d828ced69e164d4704c10202dd2e1e4a"

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

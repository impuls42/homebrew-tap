cask "codenomad" do
  version "0.14.0"
  sha256 "931a9b1938e8cd8026baa1390a6c00d4b6aceb04c4026295e12f3ee629e4472c"

  on_intel do
    sha256 "9e90b12ed8d34b8ab0074d79cc80e21917b28fc2aabcad395f861ee31f916fc6"
  end

  url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-#{version}-mac-arm64.zip"
  name "CodeNomad"
  desc "AI-powered coding assistant with remote development and sidecar support"
  homepage "https://github.com/NeuralNomadsAI/CodeNomad"

  livecheck do
    url "https://github.com/NeuralNomadsAI/CodeNomad/releases"
    strategy :github_releases
  end

  on_intel do
    url "https://github.com/NeuralNomadsAI/CodeNomad/releases/download/v#{version}/CodeNomad-#{version}-mac-x64.zip"
  end

  depends_on macos: ">= :catalina"

  app "CodeNomad.app"

  zap trash: [
    "~/Library/Application Support/ai.codenomad.CodeNomad",
    "~/Library/Caches/ai.codenomad.CodeNomad",
  ]
end
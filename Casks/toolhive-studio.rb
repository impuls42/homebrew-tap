cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.30.0"
  sha256 arm:   "85e438adbaffdae57679a83f758f5a3984c33bc23c51277dd70ece8e798942aa",
         intel: "462ac5eb9dc217e29e054102dcdb287aadb26bed14bd4706ecd854bc411c4eb6"

  url "https://github.com/stacklok/toolhive-studio/releases/download/v#{version}/ToolHive-#{arch}.dmg",
      verified: "github.com/stacklok/toolhive-studio/"
  name "ToolHive Studio"
  desc "Install, manage and run MCP servers and connect them to AI agents"
  homepage "https://toolhive.dev/"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: ">= :monterey"

  app "ToolHive.app"

  zap trash: [
    "~/Library/Application Support/toolhive",
    "~/Library/Logs/ToolHive",
  ]
end

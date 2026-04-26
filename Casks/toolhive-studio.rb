cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.32.0"
  sha256 arm:   "0f62f46a26bb3ab049ef9da005be12c62216db49eee9d30a3b0bc1ecf58508db",
         intel: "b339a2e96b8a2fc7880d2187dcbc586eec2fc63080e6638922524247ec46b886"

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

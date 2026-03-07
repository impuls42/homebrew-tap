cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.22.0"
  sha256 arm:   "44e03b664cf4e23c4f95a7fef24651a7555fe875ba7c6987208ccf9cbb8f2d8d",
         intel: "587c53aded68a717645c0ebd63bc199ca3e55b7561d7641c5173871c73324cbb"

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

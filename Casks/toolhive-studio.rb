cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.23.0"
  sha256 arm:   "69ee4341c9eb33bbe76ff2d97c297e0ca937ad8248b08e6b731ad6e28d52b976",
         intel: "2a96ce36f5ad8a6f4cb6aaa74c1428ca63bbf3e51571cbb8fc6226bc81e4b72e"

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

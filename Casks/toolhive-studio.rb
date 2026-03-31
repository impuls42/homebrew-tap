cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.26.0"
  sha256 arm:   "b85c142f73c395d705abd3406ad6bf201c91dfb6a051d4b8ea0b447fb8c8cb8b",
         intel: "28629cf666c5f80bde0bbb38c695b88d0ca8cc8ce999e5beb30e2b309bea527a"

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

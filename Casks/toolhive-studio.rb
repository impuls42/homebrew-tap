cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.27.1"
  sha256 arm:   "5da5ff3df9329fc32d5ba6eb6cee6fc896fea87c83733e34edf09adfd26659fa",
         intel: "f469016d860d391e59e45d195e2362643078a6d05e56377b46ce9c1df62ad345"

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

cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.35.0"
  sha256 arm:   "9a6328e517f93e61134ed26fd494a9538959d721705bc1991787b6cd697dbcfc",
         intel: "d367d01379e67983399c8a25e7887fd308ffbc85dd7c09c7eac939e7c1005a9a"

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

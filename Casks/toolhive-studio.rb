cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.35.4"
  sha256 arm:   "c5088bfe46f75b0fe3afadbd287c376473b1951f716225c9d180afe83560f718",
         intel: "313961fe4de51f6e3d3cc023b3c61cdf4acc218f61a8db7707b8679e5ea5fe59"

  url "https://github.com/stacklok/toolhive-studio/releases/download/v#{version}/ToolHive-#{arch}.dmg",
      verified: "github.com/stacklok/toolhive-studio/"
  name "ToolHive Studio"
  desc "Install, manage and run MCP servers and connect them to AI agents"
  homepage "https://toolhive.dev/"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :monterey

  app "ToolHive.app"

  zap trash: [
    "~/Library/Application Support/toolhive",
    "~/Library/Logs/ToolHive",
  ]
end

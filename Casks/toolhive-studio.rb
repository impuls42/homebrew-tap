cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.32.1"
  sha256 arm:   "9f3093ad959f913adaa75733a1efaa35d0d969cd3d6bdd5c3a0982f08acde805",
         intel: "ee82f4e7e52c789300d77ce2fec6f5cd84afd5faf773be9850b01a1ac774f056"

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

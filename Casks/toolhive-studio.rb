cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.36.1"
  sha256 arm:   "b6e00ff8a4426975ce30d27e6b224c08ca5e56fe9b6c30aa52264843d621c958",
         intel: "cfc98263f67e42541331f463692465dd94647a1bbb9df7593e257116316349a2"

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

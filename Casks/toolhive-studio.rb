cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.18.1"
  sha256 arm:   "9d1407dfb0369fea4203eec677e4ffc7e773a4916e4b52b469d0d162a80ebb9e",
         intel: "1725323fa78d7a69629b4c1bfcb73d4aac95fff6ca29470dad7b4f75d6ab6353"

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

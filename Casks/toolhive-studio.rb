cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.25.0"
  sha256 arm:   "8f8a8e6cc219220aac5ee4391299ab6222a7cabf704009858d6be0719687bd82",
         intel: "2991e663d30768bcfdde6f3239aedb4336fed5e8c380216b0a72ce30d235dbd0"

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

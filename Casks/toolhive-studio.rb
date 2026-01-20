cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"
  version "0.15.1"
  sha256 arm:    "19f5050ce06d54671998d3ba365d93278636ef9285cfe5eb0559334e27865da3",
         intel:  "2ea74e7711fde345bb4c4b9c91422a3d37078ffca9a45cca5f8a005582e09384"

  url "https://github.com/stacklok/toolhive-studio/releases/download/v#{version}/ToolHive-#{arch}.dmg",
      verified: "github.com/stacklok/toolhive-studio/"

  name "ToolHive Studio"
  desc "Install, manage and run MCP servers and connect them to AI agents"
  homepage "https://toolhive.dev/"

  depends_on macos: ">= :monterey"

  livecheck do
    url :url
    strategy :github_releases
  end

  app "ToolHive.app"

  zap trash: [
    "~/Library/Logs/ToolHive",
    "~/Library/Application Support/toolhive",
  ]
end

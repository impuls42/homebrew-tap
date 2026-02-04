cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.18.0"
  sha256 arm:   "edd5c3d0f452c1e3d2a91ee7b03af4f7a62c94bd79a866d16dcc29938ba53ec7",
         intel: "3b4ef74a2347daebb5dcc8e7ace1ba765b2db5f9fd17e085bc93c408d08872a4"

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

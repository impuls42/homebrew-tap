cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.20.0"
  sha256 arm:   "1b8ad38b205b0a955e71c3ae6b488397d153cc1a4943cb90bd1be0091457bc89",
         intel: "7e2a2696b13652eed7fa9cb6f2d91d6ef5a98deb11347a71d58628a2447729ba"

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

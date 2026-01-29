cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.17.3"
  sha256 arm:   "84ae4defa2e2ddc3a11c380c070c169fc694ed210fbc255caa99f95c179649e5",
         intel: "f8a7135053733f6045f4d32db859e55f8ed468ac53a4b582d18008b554acd557"

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

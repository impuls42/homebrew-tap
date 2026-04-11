cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.28.1"
  sha256 arm:   "48ca9ac0f8214cbbc466b1706518d25f4fe10ba179cd4c706ea1d5805049cb7d",
         intel: "06390c0837de5cf85baed3cc7df6b87b4a35ce8d0bfe779fd285709d5c558f87"

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

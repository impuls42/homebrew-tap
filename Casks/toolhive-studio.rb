cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.35.1"
  sha256 arm:   "61620dcc0b007c9817f003f9e449e4bd1a0c4c8284635596c96b30fb9c1d051c",
         intel: "dd119904b8a8daa720c0891381e0bfe4d79dd14e5350586d447004d1da244569"

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

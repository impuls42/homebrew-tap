cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.35.3"
  sha256 arm:   "87ae47d83c6085d55bb87686b2e448671e3dff51a7c11030a6bec17cd07eebaa",
         intel: "4c82ea504285b150abb8da9d3c763975fe899e23daa8e5e170a622ba624c9447"

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

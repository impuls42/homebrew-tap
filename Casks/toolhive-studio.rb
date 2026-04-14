cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.29.0"
  sha256 arm:   "c74eb29b528c5dd450b71add6eb013a3d4ce44581cc33c61aa715e336769c0da",
         intel: "9c7b8c0c70aa9e30a89757953add9bbd0ba2e2ee571fba86f45056dab092e0b4"

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

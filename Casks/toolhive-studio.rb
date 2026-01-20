cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.17.0"
  sha256 arm:   "03b9389cd2fd9b58a77a9a9189b440145aea93c109fac25a3c0a2c6d97840fdc",
         intel: "0d22ec74bc9cff6bef3274ef4df88a3f162f4196c88c202ded0762291fc9b52a"

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

cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.24.0"
  sha256 arm:   "12674e40db75de4b74511df1e19812022ebefcc152d2efeb7774b37831ad5d46",
         intel: "d49903d5e2b5c55503ad555da5586b830f181b5fdb5102d2f82f0dfa3502455b"

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

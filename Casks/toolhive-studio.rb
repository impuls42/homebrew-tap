cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.33.1"
  sha256 arm:   "335d8eac7e4701584577199c16755df6dec9e12064c94ed0510d503b772e8866",
         intel: "f85b15aa08be8dc435d17cb3c9350432352d91ae2c1d85fab0dcfba6b4b57d96"

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

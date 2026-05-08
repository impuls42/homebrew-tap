cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.34.0"
  sha256 arm:   "72d826e36c474dd415c4ef54f34b150edf170fb5c1b3866cf7a7cbefdb60955a",
         intel: "7604088e511e4b7953dfa5380c8b4a5b3314216d35129724db39289989b12fdb"

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

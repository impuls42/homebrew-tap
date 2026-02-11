cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.19.1"
  sha256 arm:   "e130b624dbf9eae096c08d19547c4ca78d750f25c39950fba58c064c9aadc9d1",
         intel: "3aa0ecb5c641366adebd4dd046c04f43aba51809e198a7f179753ebf0530e76d"

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

cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.39.1"
  sha256 arm:   "53afee92b67e9c52acaa578656079f3ba221da7d545b7ac072635d6574b8dc58",
         intel: "069d1fd6b039bf270100f1d9d02c99d5715f6bdb1736a6a5cbb926bb611f7b06"

  url "https://github.com/stacklok/toolhive-studio/releases/download/v#{version}/ToolHive-#{arch}.dmg",
      verified: "github.com/stacklok/toolhive-studio/"
  name "ToolHive Studio"
  desc "Install, manage and run MCP servers and connect them to AI agents"
  homepage "https://toolhive.dev/"

  livecheck do
    url :url
    strategy :github_releases do |json|
      json.filter_map do |r|
        next if r["prerelease"] || r["draft"]

        r["tag_name"].delete_prefix("v") if r["assets"]&.any? { |a| a["name"] == "ToolHive-arm64.dmg" }
      end.first
    end
  end

  depends_on macos: :monterey

  app "ToolHive.app"

  zap trash: [
    "~/Library/Application Support/toolhive",
    "~/Library/Logs/ToolHive",
  ]
end

cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.40.2"
  sha256 arm:   "46a4e966788cbd37c99b23200cc4c74d13149be23029ab44ace10218c24414a7",
         intel: "2c2f5216a20d2a6521a1a7f016ae808c1fa0ac2268be5b0d71e95888e4e0f1a2"

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

  depends_on macos: :ventura

  app "ToolHive.app"

  zap trash: [
    "~/Library/Application Support/toolhive",
    "~/Library/Logs/ToolHive",
  ]
end

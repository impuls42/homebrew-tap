cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.41.0"
  sha256 arm:   "847949de338e887491aaadd8ca6b455a2ce09d3f22d86d842570219a7c6ba217",
         intel: "2f7364ea16d5cb1f9986a5773a82f6a4e0bca40b0e64035714929ac4e4b52767"

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

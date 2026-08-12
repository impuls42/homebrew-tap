cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.39.4"
  sha256 arm:   "2dba7acde810abd9eddbb3429afbd833fac594eb57ed4a4935926c09da270822",
         intel: "49a0eadb3c36028e21da11aceeb1e3eb948116cddb12e282e5b55e08acdd7a0d"

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

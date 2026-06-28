cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.36.5"
  sha256 arm:   "2c5426982d0c075e11c5a7cfbd80e3dca14d0f7c0390a9e3e7e3e2318a0e0a6e",
         intel: "b2e73f6ba178fac163c4a336e6c81971333d0dead2ce0a0660d2702b196de062"

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

cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.40.0"
  sha256 arm:   "bb91250bce9f94dc48fed6cf32c96646ae5fc4e1078d5ec8b657fd36d7eef387",
         intel: "c501c239fd4e6a31e04c9d17fb86b130c24747a0bd129dac751609bf46d929e6"

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

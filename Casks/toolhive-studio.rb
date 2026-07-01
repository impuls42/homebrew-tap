cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.36.6"
  sha256 arm:   "de099ca910565650da318bd430d160ba116f0f2c1ce003d36d250c31150c6b48",
         intel: "f46b1fb1d6b46d0906bafe32e69bbe67ac9d36e5aa77fa1e6fde93655b7b2ac7"

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

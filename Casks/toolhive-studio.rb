cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.37.0"
  sha256 arm:   "3b95caea82d9de8746eafbbe93d10a77ce0b5662c2de64f0de6c7b0cbd44b996",
         intel: "f938b056a1ff536f31a41c52221fd817b49f326019a6a8d539b7d22f45484e6e"

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

cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.42.0"
  sha256 arm:   "cb3a93dde3e7120bd0197c86e89f7b55c376f2b21bf0e14a72a8bff4775e86fb",
         intel: "214fd93aded5fb06f232cc427176fbe13f088219b9c9a36ea57d93d433dc1292"

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

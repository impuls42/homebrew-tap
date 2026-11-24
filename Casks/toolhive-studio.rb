cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.41.1"
  sha256 arm:   "4f0f798da81b94aa99a16ca0cd4f9516d7245ebed1cf95802b5f25d2be410308",
         intel: "61e75564799de2c7828cabaf92e3110507fa2e7dc258935d50b1debe976c3049"

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

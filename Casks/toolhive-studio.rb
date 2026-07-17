cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.38.0"
  sha256 arm:   "ba2064e36f49992c45d322b78b0191f819b15a9d4b8e45a6a1c41c41b2449c88",
         intel: "efde56951962f25a67618fabf2a6bbe65a5ba72ac94d45e8054ed571d2e8deda"

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

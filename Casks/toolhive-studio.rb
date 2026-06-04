cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.36.0"
  sha256 arm:   "e0b7b9b06fb4685f52c3bcd431a498e36e86277dce50e673eca9ec448b52cc98",
         intel: "cdbda49aa97dadaa9cf79858e43838c53af28d804ba3745a1bcf23533a5ffa8f"

  url "https://github.com/stacklok/toolhive-studio/releases/download/v#{version}/ToolHive-#{arch}.dmg",
      verified: "github.com/stacklok/toolhive-studio/"
  name "ToolHive Studio"
  desc "Install, manage and run MCP servers and connect them to AI agents"
  homepage "https://toolhive.dev/"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :monterey

  app "ToolHive.app"

  zap trash: [
    "~/Library/Application Support/toolhive",
    "~/Library/Logs/ToolHive",
  ]
end

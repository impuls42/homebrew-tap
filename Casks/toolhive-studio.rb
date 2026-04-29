cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.33.0"
  sha256 arm:   "c7e0f6f89c5a1b6e2bae59d4deb346b1e92c6a7a2a4667b0a88c83c5ed1c0d05",
         intel: "e135906a7f8b88633863ea04101b48d8ed364c187b32a228a62fc4a8bfa1210a"

  url "https://github.com/stacklok/toolhive-studio/releases/download/v#{version}/ToolHive-#{arch}.dmg",
      verified: "github.com/stacklok/toolhive-studio/"
  name "ToolHive Studio"
  desc "Install, manage and run MCP servers and connect them to AI agents"
  homepage "https://toolhive.dev/"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: ">= :monterey"

  app "ToolHive.app"

  zap trash: [
    "~/Library/Application Support/toolhive",
    "~/Library/Logs/ToolHive",
  ]
end

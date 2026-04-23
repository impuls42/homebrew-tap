cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.31.0"
  sha256 arm:   "c5c586ce0f0736b783cfb7c16a30ef547e2f2e8cf40c37054db3f3febf3b3f2b",
         intel: "d997b2659444b1252c656de022742d2e43204c4344134160f78eaef7c868634e"

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

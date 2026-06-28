cask "mcp-router" do
  version "0.6.3"
  sha256 "2282c9b9ada119eb9fb396d4835a6c78ce465e6b407f3c87b1de25eafd447087"

  url "https://github.com/mcp-router/mcp-router/releases/download/v#{version}/MCP-Router.dmg"
  name "MCP Router"
  desc "Desktop application for managing Model Context Protocol (MCP) servers"
  homepage "https://github.com/mcp-router/mcp-router"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :monterey

  app "MCP Router.app"

  zap trash: [
    "~/Library/Application Support/mcp-router",
    "~/Library/Logs/MCP Router",
  ]
end

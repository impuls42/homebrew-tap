cask "mcp-router" do
  version "0.6.2"
  sha256 "125dcbba4dde6cc573f5e30e2d9cb35f91eee00ea6bba565ce9518b4639580a7"

  url "https://github.com/mcp-router/mcp-router/releases/download/v#{version}/MCP-Router.dmg"
  name "MCP Router"
  desc "Desktop application for managing Model Context Protocol (MCP) servers"
  homepage "https://github.com/mcp-router/mcp-router"

  livecheck do
    url :url
    strategy :github_releases
  end

  app "MCP Router.app"

  zap trash: [
    "~/Library/Application Support/mcp-router",
    "~/Library/Logs/MCP Router",
  ]
end

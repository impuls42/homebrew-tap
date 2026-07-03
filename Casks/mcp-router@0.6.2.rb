cask "mcp-router@0.6.2" do
  # Intentionally pinned to 0.6.2 pending an upstream fix in a later release.
  # No livecheck by design: this cask must never track upstream. The frozen
  # `version` below is what holds it; livecheck is omitted so it isn't flagged.
  # Switch back to the evergreen `mcp-router` cask once a fixed version ships.
  version "0.6.3"
  sha256 "2282c9b9ada119eb9fb396d4835a6c78ce465e6b407f3c87b1de25eafd447087"

  url "https://github.com/mcp-router/mcp-router/releases/download/v#{version}/MCP-Router.dmg"
  name "MCP Router"
  desc "Desktop application for managing Model Context Protocol (MCP) servers"
  homepage "https://github.com/mcp-router/mcp-router"

  conflicts_with cask: "mcp-router"
  depends_on macos: :monterey

  app "MCP Router.app"

  zap trash: [
    "~/Library/Application Support/mcp-router",
    "~/Library/Logs/MCP Router",
  ]
end

cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.36.2"
  sha256 arm:   "99783c181be532b4fdec9555d0786b9ddb5ffa997d7ca97e0afa2876d4151390",
         intel: "4eaed3031b8f1e84c924f035f9fbdead41e6d1b56f25e460c60ac220ddaf97dd"

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

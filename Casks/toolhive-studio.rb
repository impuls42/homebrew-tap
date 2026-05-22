cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.35.2"
  sha256 arm:   "e122db01076bd739b41174e06f42e6db44365bfc24dc40a3a7999ef606f40e6c",
         intel: "361a7b3e36db1fefcdea8960a8cb723bcf12d6d5b4be6224bfd2256068bdc6c0"

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

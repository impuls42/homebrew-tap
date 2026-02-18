cask "toolhive-studio" do
  arch arm: "arm64", intel: "x64"

  version "0.21.0"
  sha256 arm:   "c781c7ac66529cd9b55dc9da8d70e84ab1b5fc458d8bd8bc01c4cfc7c6c4e0c7",
         intel: "8bdf9c4918d1c5c2ea53ff6a732998fb3593d19f0c3d808d017693501da6c9a8"

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

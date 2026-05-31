cask "mux" do
  arch arm: "arm64", intel: "x86_64"

  version "0.26.0"
  sha256 arm:   "4af3bc36d1fc6bd36d2825e3870d013576e5e58ed27e305bd27d53f452ecc048",
         intel: "d268ed5799580af90431a20e2ba504c5daf5d8ddbc4919535ea37046d6eb95a5"

  url "https://github.com/coder/mux/releases/download/v#{version}/mux-#{version}-#{arch}.AppImage"
  name "Mux"
  desc "Desktop app for isolated, parallel agentic development"
  homepage "https://github.com/coder/mux"

  livecheck do
    url :url
    strategy :github_releases
  end

  container type: :naked

  binary "mux-#{version}-#{arch}.AppImage", target: "mux"
end

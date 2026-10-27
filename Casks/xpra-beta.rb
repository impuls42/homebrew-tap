cask "xpra-beta" do
  arch arm: "arm64"

  version "8.0,43412"
  sha256 arm: "bbf2cb6df8e278050c69af88f8d35f6a5c4faec0ad3b3ef25b92804e0f8ab6e9"

  revision_suffix = version.csv.second.present? ? "-r#{version.csv.second}" : ""
  url "https://xpra.org/beta/MacOS/#{arch}/Xpra-#{arch}-#{version.csv.first}#{revision_suffix}.dmg"
  name "Xpra Beta"
  desc "Screen and application forwarding system (beta builds)"
  homepage "https://xpra.org/"

  livecheck do
    url "https://xpra.org/beta/MacOS/arm64/"
    regex(/Xpra-arm64[_-]v?(\d+(?:\.\d+)+)-r(\d+)\.dmg["' >]/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map do |match|
        v, r = match
        "#{v},#{r}"
      end
    end
  end

  conflicts_with cask: "xpra"
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Xpra.app"
  command_wrapper "xpra",
                  executable: "#{appdir}/Xpra.app/Contents/MacOS/Xpra"

  postflight_steps do
    run "/usr/bin/codesign",
        args:           ["--force", "--deep", "--sign", "-", "{{appdir}}/Xpra.app"],
        must_succeed:   false,
        writable_paths: ["{{appdir}}/Xpra.app"]
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Xpra.app"],
        must_succeed:   false,
        writable_paths: ["{{appdir}}/Xpra.app"]
  end

  zap delete: "/Library/Application Support/Xpra",
      trash:  [
        "~/Library/Application Support/Xpra",
        "~/Library/Saved Application State/org.xpra.xpra.savedState",
      ]
end

cask "xpra" do
  arch arm: "arm64"

  version "6.5.6,0"
  sha256 arm: "0446e0ba03cb819ddbc2053c62c4b2abbee1a75c9807a9c86b9c752f0d908b00"

  revision_suffix = version.csv.second.present? ? "-r#{version.csv.second}" : ""
  url "https://xpra.org/dists/MacOS/#{arch}/Xpra-#{arch}-#{version.csv.first}#{revision_suffix}.dmg"
  name "Xpra"
  desc "Screen and application forwarding system"
  homepage "https://xpra.org/"

  livecheck do
    url "https://xpra.org/dists/MacOS/arm64/"
    regex(/Xpra-arm64[_-]v?(\d+(?:\.\d+)+)-r(\d+)\.dmg["' >]/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map do |match|
        v, r = match
        "#{v},#{r}"
      end
    end
  end

  conflicts_with cask: "xpra-beta"
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Xpra.app"
  command_wrapper "xpra",
                  executable: "#{appdir}/Xpra.app/Contents/MacOS/Xpra"

  postflight_steps do
    run "/usr/bin/codesign",
        args:           ["--force", "--deep", "--sign", "-", "{{appdir}}/Xpra.app"],
        writable_paths: ["{{appdir}}/Xpra.app"]
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Xpra.app"],
        writable_paths: ["{{appdir}}/Xpra.app"]
  end

  zap delete: "/Library/Application Support/Xpra",
      trash:  [
        "~/Library/Application Support/Xpra",
        "~/Library/Saved Application State/org.xpra.xpra.savedState",
      ]
end

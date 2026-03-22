class Dagger < Formula
  desc "Integrated platform to orchestrate the delivery of applications"
  homepage "https://dagger.io"
  version "0.20.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/dagger/dagger/releases/download/v0.20.1/dagger_v0.20.1_darwin_amd64.tar.gz"
      sha256 "1a44b55783dcc0ad22a913cc54ddcae4e682b4748a9be44fefb4b18628006b8a"
    end
    on_arm do
      url "https://github.com/dagger/dagger/releases/download/v0.20.1/dagger_v0.20.1_darwin_arm64.tar.gz"
      sha256 "e735d38d50834f37265605a5ef6955a2f28bff4997f1e324d6de55cd8f0d5215"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/dagger/dagger/releases/download/v0.20.1/dagger_v0.20.1_linux_amd64.tar.gz"
      sha256 "012afa819a9d459389af34f1055c064dc117881080bf91dc31a6b4694f2bcf99"
    end
    on_arm do
      url "https://github.com/dagger/dagger/releases/download/v0.20.1/dagger_v0.20.1_linux_arm64.tar.gz"
      sha256 "da4da814e0a37540c88bd107ea4667bcdae1480a6656088f41ecad18f02b6334"
    end
  end

  def install
    bin.install "./dagger"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dagger version")
  end
end

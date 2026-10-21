class Runfree < Formula
  desc "Run coding agents in Docker with network policy and proxy-held credentials"
  homepage "https://github.com/genged/runfree"

  url "https://github.com/genged/runfree/releases/download/v0.6.0/runfree-0.6.0-darwin-arm64.tar.gz"
  sha256 "ebbfa82764f48c79b2f1ccbbbb59c30cb1a9673157e2ea56890ac6ba45654754"

  # Release binaries are published for Apple Silicon macOS only.
  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "runfree"
  end

  def caveats
    <<~EOS
      runfree runs agents in Docker and is supported with Docker Desktop.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/runfree version").strip
    assert_match "runfree init", shell_output("#{bin}/runfree help")
  end
end

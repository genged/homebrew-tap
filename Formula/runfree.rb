class Runfree < Formula
  desc "Run coding agents in Docker with network policy and proxy-held credentials"
  homepage "https://github.com/genged/runfree"

  url "https://github.com/genged/runfree/releases/download/v0.7.0/runfree-0.7.0-darwin-arm64.tar.gz"
  sha256 "08455819f2ec1b33364333a1626c9ddf2e90a3c30177935dca9d554981918daa"

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

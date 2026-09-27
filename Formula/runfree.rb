class Runfree < Formula
  desc "Run coding agents in Docker with network policy and proxy-held credentials"
  homepage "https://github.com/genged/runfree"

  url "https://github.com/genged/runfree/releases/download/v0.5.2/runfree-0.5.2-darwin-arm64.tar.gz"
  sha256 "30dcb2ce6b815281da477d38a58d779f94ec47601b392f86130dc368819b9de0"

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

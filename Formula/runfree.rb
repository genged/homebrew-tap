class Runfree < Formula
  desc "Start isolated Claude Code or Codex workspaces"
  homepage "https://github.com/genged/runfree"

  version "0.1.0"

  depends_on :macos

  # runfree stable release assets are published by genged/runfree.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/runfree/releases/download/v0.1.0/runfree-0.1.0-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/genged/runfree/releases/download/v0.1.0/runfree-0.1.0-darwin-x64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  head do
    url "https://github.com/genged/runfree.git", branch: "main"
    depends_on "oven-sh/bun/bun" => :build
  end

  def install
    if build.head?
      system "bun", "scripts/generate-assets.ts"
      system "bun", "build", "src/cli.ts", "--compile", "--outfile", "dist/runfree"
      bin.install "dist/runfree"
    else
      bin.install "runfree"
    end
  end

  def caveats
    <<~EOS
      macOS runtime commands require:
      - Docker Desktop or OrbStack
    EOS
  end

  test do
    version_output = shell_output("#{bin}/runfree version")
    assert_match(/\b\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?\b/, version_output)

    assert_match "runfree init", shell_output("#{bin}/runfree help")
  end
end

class Capshelf < Formula
  desc "Manage shared Claude Code and Codex configuration across projects"
  homepage "https://github.com/genged/capshelf"

  version "0.7.0"

  uses_from_macos "git"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.7.0/capshelf-0.7.0-darwin-arm64.tar.gz"
      sha256 "6bbdea189c979641d416a155f0b859e63911c33ec3f588056dd34fea2e94d9b2"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.7.0/capshelf-0.7.0-darwin-x64.tar.gz"
      sha256 "d70d4405c2fb6156937b9633cb06411543cf2318a9936dbcf4b4366d32529db4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.7.0/capshelf-0.7.0-linux-arm64.tar.gz"
      sha256 "c06af82fe05733b5661254faa73451cb4f71c5107c0f56ce7d93662638ac14e0"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.7.0/capshelf-0.7.0-linux-x64.tar.gz"
      sha256 "48ac43d6b0a3458c74d88e7579931c0e8ac7694856b030e88b512b5040417bd2"
    end
  end

  head do
    url "https://github.com/genged/capshelf.git", branch: "main"
    depends_on "oven-sh/bun/bun" => :build
  end

  def install
    if build.head?
      system "bun", "install", "--frozen-lockfile"
      system "bun", "run", "build"
      bin.install "dist/capshelf"
    else
      bin.install "capshelf"
    end
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/capshelf --version").strip
    assert_match "manage shared coding-agent config across projects", shell_output("#{bin}/capshelf --help")
  end
end

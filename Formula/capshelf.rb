class Capshelf < Formula
  desc "Manage shared Claude Code and Codex configuration across projects"
  homepage "https://github.com/genged/capshelf"

  version "0.12.0"

  uses_from_macos "git"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.12.0/capshelf-0.12.0-darwin-arm64.tar.gz"
      sha256 "50b830538ee2020dfd1cdf2f93bf76ec30fa97362aff97ae9a039a896a99adf1"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.12.0/capshelf-0.12.0-darwin-x64.tar.gz"
      sha256 "3e6f37bfa4052c08e8d960d5b67bd62c6325a5e61ab92311edea40de71cdccc4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.12.0/capshelf-0.12.0-linux-arm64.tar.gz"
      sha256 "0cc88dc65963d25d8a7b3d73741a6289fceede8a1a9b3dbf15a4b31fc189e685"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.12.0/capshelf-0.12.0-linux-x64.tar.gz"
      sha256 "6d37b2c0255c052c0eec82740637131e686785062eb489e9900cd2538081e643"
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

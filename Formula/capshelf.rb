class Capshelf < Formula
  desc "Manage shared Claude Code and Codex configuration across projects"
  homepage "https://github.com/genged/capshelf"

  version "0.13.0"

  uses_from_macos "git"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.13.0/capshelf-0.13.0-darwin-arm64.tar.gz"
      sha256 "c4fde831679bb5a932b1fb739787b3b196c9ee4648556ec2edfd1c40d4886be0"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.13.0/capshelf-0.13.0-darwin-x64.tar.gz"
      sha256 "f581766260bad938e80ac30607fb265ce87cb7607658b2481498d4de85dd2878"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.13.0/capshelf-0.13.0-linux-arm64.tar.gz"
      sha256 "43565dc9820695f8a148257598bfbb4a63c168bcd31d5bc75a2f12151df23421"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.13.0/capshelf-0.13.0-linux-x64.tar.gz"
      sha256 "f5500febdf8c428d02ae294d7606ebde99cba6646bef67d49d02bd0f62428dab"
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

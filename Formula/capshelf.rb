class Capshelf < Formula
  desc "Manage shared Claude Code and Codex configuration across projects"
  homepage "https://github.com/genged/capshelf"

  version "0.10.0"

  uses_from_macos "git"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.10.0/capshelf-0.10.0-darwin-arm64.tar.gz"
      sha256 "cdac7f5644aad1c79cce672f101bbc8696e540b31242bd39db214d090857a5f5"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.10.0/capshelf-0.10.0-darwin-x64.tar.gz"
      sha256 "b76a7cfe831b4722e9a4a0fe0e234a3c6990c92a70dfee172b512185aedd8b99"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.10.0/capshelf-0.10.0-linux-arm64.tar.gz"
      sha256 "41a16e93c08ca33d536f61c8233743054136a25051653c6da0ec0ab70a3f238f"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.10.0/capshelf-0.10.0-linux-x64.tar.gz"
      sha256 "113727acda8bc0f424d08449b12bba4c8e9591a86aba70e9c28ecc00f5a5268f"
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

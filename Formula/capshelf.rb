class Capshelf < Formula
  desc "Manage shared Claude Code and Codex configuration across projects"
  homepage "https://github.com/genged/capshelf"

  version "0.11.0"

  uses_from_macos "git"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.11.0/capshelf-0.11.0-darwin-arm64.tar.gz"
      sha256 "f5be5ca7058e58c76e5f50bffeb0deccdbc436d8891e8c9e6bc5a4447705967e"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.11.0/capshelf-0.11.0-darwin-x64.tar.gz"
      sha256 "436c58c20a08bb304b8e3cd1c2d8eb731bcecb207044c90c36d5d354e1a3717f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.11.0/capshelf-0.11.0-linux-arm64.tar.gz"
      sha256 "118eb9ccd37a69e23c884b17feea4f266979bd43465298223fc9f06f6c46eee6"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.11.0/capshelf-0.11.0-linux-x64.tar.gz"
      sha256 "cfc871339825330cb2b96da81071bf8d336f151c30fb4f0357462e4a4a09009d"
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

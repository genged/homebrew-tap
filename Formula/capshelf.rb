class Capshelf < Formula
  desc "Manage shared Claude Code and Codex configuration across projects"
  homepage "https://github.com/genged/capshelf"

  version "0.6.0"

  uses_from_macos "git"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.6.0/capshelf-0.6.0-darwin-arm64.tar.gz"
      sha256 "9a4f855d5c799dd82a4b1115c329315608ab4b69c0a144e66e8525965506ca69"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.6.0/capshelf-0.6.0-darwin-x64.tar.gz"
      sha256 "b6c1a88260ec60ccff9e8b8c42c51f13bf7527f254a77b78744fd83e2f0758a7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.6.0/capshelf-0.6.0-linux-arm64.tar.gz"
      sha256 "843966f63007a681c4f8cd864e3a06681222b662ef553166f7b04e55764a58dd"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.6.0/capshelf-0.6.0-linux-x64.tar.gz"
      sha256 "ffe5983037d1955347891477dc6018f208793a91f0400d2892ac30871caa373b"
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

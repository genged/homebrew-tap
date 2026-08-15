class Capshelf < Formula
  desc "Manage shared Claude Code and Codex configuration across projects"
  homepage "https://github.com/genged/capshelf"

  version "0.8.0"

  uses_from_macos "git"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.8.0/capshelf-0.8.0-darwin-arm64.tar.gz"
      sha256 "2fa453ca1021b10cada4e99ed5179e0bfd5776de4785ff6cdcfc132f6f3d0507"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.8.0/capshelf-0.8.0-darwin-x64.tar.gz"
      sha256 "da537d4485c0485041de140d41178c7895f35cf140a222193c0df6623d557d5b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.8.0/capshelf-0.8.0-linux-arm64.tar.gz"
      sha256 "a032984cc8ca6e8a42252c5b860791feaad4e57fa54fd20d0e1e42f743072a0a"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.8.0/capshelf-0.8.0-linux-x64.tar.gz"
      sha256 "7dc3225d712b8ebf539751662d1a54f6b57f015d706150f4bcbe25f07dc51211"
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

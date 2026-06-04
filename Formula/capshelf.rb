class Capshelf < Formula
  desc "Manage shared Claude Code and Codex configuration across projects"
  homepage "https://github.com/genged/capshelf"

  version "0.3.0"

  uses_from_macos "git"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.3.0/capshelf-0.3.0-darwin-arm64.tar.gz"
      sha256 "bb003bfeb6b930c33e4d2a8ea000c1d380f591d8acf01bd50d2cf3d11cef82b8"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.3.0/capshelf-0.3.0-darwin-x64.tar.gz"
      sha256 "abd1c86f73838c10c5eb4ade49c6ade018f27c9af1af02223360c2e23f1f9b90"
    end
  end

#   on_linux do
#     if Hardware::CPU.arm?
#       url "https://github.com/genged/capshelf/releases/download/v0.1.0/capshelf-0.1.0-linux-arm64.tar.gz"
#       sha256 "422e74c165ae6afec4a9eb66a3f00a6a7b23bf3e143104b5f5376b44f188d128"
#     else
#       url "https://github.com/genged/capshelf/releases/download/v0.1.0/capshelf-0.1.0-linux-x64.tar.gz"
#       sha256 "5a33316b259d97bfe747dc841a695f4ccc2db5c3c4cfefdab6cefef38b3f1795"
#     end
#   end

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
    assert_match "manage shared Claude Code / Codex config", shell_output("#{bin}/capshelf --help")
  end
end

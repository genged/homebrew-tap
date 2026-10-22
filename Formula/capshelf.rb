class Capshelf < Formula
  desc "Manage shared Claude Code and Codex configuration across projects"
  homepage "https://github.com/genged/capshelf"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.14.0/capshelf-0.14.0-darwin-arm64.tar.gz"
      sha256 "0ec9afdedb72cbf43baed2714685ef351f5618d101a1f81140d4f0df7866b73c"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.14.0/capshelf-0.14.0-darwin-x64.tar.gz"
      sha256 "9931f4cb42d9bae54a122b6389f2da60631804cbca1bf7fb87d39ccae1f6ccca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/genged/capshelf/releases/download/v0.14.0/capshelf-0.14.0-linux-arm64.tar.gz"
      sha256 "4f114d77ea2bfcf8e71c0c946ee5109b9ec243a9dd33e35c74e589c1f50ef619"
    else
      url "https://github.com/genged/capshelf/releases/download/v0.14.0/capshelf-0.14.0-linux-x64.tar.gz"
      sha256 "cbb394d68fc5f9bcf43c2448c852f2bc3c79a91989cb8cc7de188a689432bd77"
    end
  end

  def install
    bin.install "capshelf"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/capshelf --version").strip
    assert_match "Usage: capshelf", shell_output("#{bin}/capshelf --help")
  end
end

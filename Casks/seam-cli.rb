cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.46.0"
  sha256 arm:          "d05e3f5d4d4cc53d853f453a84cc31fc2ec6727beecaec69f4425bd5b97dc536",
         intel:        "20dab97f9ab820afb1fe6fed45d35a7e52d5f7ded67ffddb787a6ea24e291e70",
         arm64_linux:  "9eeb4fe31940b0f23b5ca9ad864c26569a24536c2f9e13de82b2b0cfbc27ebec",
         x86_64_linux: "5d3a62a3ee4314b8dc4358f19796fdeb7d950742e802e41050a529aa54371ea0"

  on_macos do
    zap trash: [
      "~/Library/Caches/seam",
      "~/Library/Logs/seam",
      "~/Library/Preferences/seam",
    ]
  end
  on_linux do
    zap trash: [
      "~/.cache/seam",
      "~/.config/seam",
      "~/.local/state/seam",
    ]
  end

  url "https://github.com/seamapi/cli/releases/download/v#{version}/seam-v#{version}-#{os}-#{arch}"
  name "Seam CLI"
  desc "Command-line interface for interacting with the Seam API"
  homepage "https://github.com/seamapi/cli"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  container type: :naked

  binary "seam-v#{version}-#{os}-#{arch}", target: "seam"
  generate_completions_from_executable "seam-v#{version}-#{os}-#{arch}",
                                       "completion",
                                       "--loader",
                                       base_name: "seam"
end

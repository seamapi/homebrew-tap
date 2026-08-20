cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.32.0"
  sha256 arm:          "512f3ae7dc0c6558763e95c3f969d66a1be7052dc400c347504577aa09a51c04",
         intel:        "156b62524dc6d9603df39b629ebc4142fb08fdfee3ab8722bfe7c9068e4ff208",
         arm64_linux:  "64ac37b5c94daaeb4ff3d3657853cff4545b484ecce92d1b91663d35425f9722",
         x86_64_linux: "eee9a6cecfd28a5a8fad1003a5d803b44449cef549d039bf936852ab3d0d5b1c"

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

cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.29.0"
  sha256 arm:          "822fa8c4d23b68703267764986c89e8a7cebb55af0c27076927bc0f08ba3d236",
         intel:        "07727daaf42e1629971fd92a804ba3178dde5537ac30e492036c65f5bbeb8006",
         arm64_linux:  "30f980d9966a5c5dcaadbbdf86f49357628cd3eaa1ae0cd278889443a64df584",
         x86_64_linux: "2fb4ed605b7596e4d2da770a4cc84c59df1e6f3bf0c4d3e5499a1dced582335a"

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

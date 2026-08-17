cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.27.0"
  sha256 arm:          "a83fa2d34d27b2b7a50e73ad0933b5261922748b79b67a0a83b922213e48e8e1",
         intel:        "4922573b0e3515702349572bdb1972bb75a2aa1dbdd7e2712f566de72ef12892",
         arm64_linux:  "9b9f8f0a7e793ea9190d6f22813fafa8d878d331612b89c3c9727e983aee8605",
         x86_64_linux: "33850282b76a6d57cf1efd6073c4416e83ec4a0ca2ee5779dd1585b2c219223d"

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

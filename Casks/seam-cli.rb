cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.42.0"
  sha256 arm:          "6a5c06cb00df0894fb73fb92250dcf6312789323a0694e7fa539687e68f03797",
         intel:        "463b763ee954aca5fee6b2a62ba27b02dcb46ee09b7d0cbfda2f10edd16caeb6",
         arm64_linux:  "4fe84c519778810c1667d0b3a65cf73ec85da2d11af4886e42d18622df73551b",
         x86_64_linux: "b6956d0ecd98d12b6970cd98631ba1478e4b5bb3ffeea7f76ff299e54876257d"

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

cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.60.0"
  sha256 arm:          "a36a8136cd1b8d62ad74bcaa85f0da36cde5bd28d9f7f24c6af3fc4839972747",
         intel:        "3dc374b9083fb6c8eb859d1bd987e512c5a91705c0c524fbe19ffe8e664040ac",
         arm64_linux:  "dfdbb246e31fe34df11406c997965aa4fadd97505018fd6ff82622b5748d56d4",
         x86_64_linux: "06b7f3aa9835efba18ebb48d025fb3f16b67495980bdf436b84c2c74bd138469"

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

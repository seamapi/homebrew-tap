cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.34.1"
  sha256 arm:          "01cb60b25ad78999b47ef58cc0f0ca6875bce9c732a5a1720f85d032a68e7215",
         intel:        "54ecd15760a43aa52b6a0a136880d28c7230632fb4d3b69f131a1429d4f86da1",
         arm64_linux:  "6a648eff5f39d6f0f7b4cd88cfbb56611921b11d80d875185f6bad81cadc8297",
         x86_64_linux: "af97bed1d73875a4dcfdd50981d590e7acf89f3682129fbb67924c487d8b16ae"

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

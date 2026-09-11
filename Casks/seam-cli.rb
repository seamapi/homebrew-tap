cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.41.0"
  sha256 arm:          "88df79e7d3e6ef62ed32df93ad71c6594becbcf267e8f7dafc09acf8af2df017",
         intel:        "00b9c21cd56f9150bddec29dfa514e55fb70a05deb7807869ef27e5fda3ee3eb",
         arm64_linux:  "fcd5a6d3ebb4bcd6d3c448ffe1c4dc970ed6f4cf1c5acc2fc75da3cebee57bcf",
         x86_64_linux: "9de7181ccd914ddbd92f2a769ef93218c66e5a075391855e66988d78207d811a"

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

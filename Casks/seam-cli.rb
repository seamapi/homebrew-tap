cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.50.0"
  sha256 arm:          "a785adc56e4a84c552967455dd01f1f308099e4bd1bb6ab10c609cbaf9611932",
         intel:        "ed163278bc5fff0a3686aeb60e6d5b2697147c57c75a8ca4ded9f4a04825b85c",
         arm64_linux:  "dba1bfe31e101ad5d237f33aa88c55c0d9b423c7812dd1024ae058fce410e2d5",
         x86_64_linux: "50e49b1a11d29e5935cbf006d57e9faa6c7b58ffecaf323ae63b8fb9c865333d"

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

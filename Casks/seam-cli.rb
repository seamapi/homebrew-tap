cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.44.0"
  sha256 arm:          "028083a0a72b1ececdb4c997dc83ddeeab51827deefef8414561caaf6cb59dbc",
         intel:        "e1ad8b4c616059d377042774b79752fd4ddd3a99d9ae8525d9cec69d716d628a",
         arm64_linux:  "407ad95a1c417b550648b6255685e7e72742e19df97b64e5f3b50d8126f2a679",
         x86_64_linux: "debb8e6ac5d109bd5deec9b24acc379802e84a8969e9c99e234a1c63b89d83a6"

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

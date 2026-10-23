cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.48.0"
  sha256 arm:          "3b24d329a09241082e7f048a71a0ed26373ae0e010d31cf7223ad8249857df3b",
         intel:        "49bb5a155ff9fd4a0a30fd08c9ed39dc499497886097c39b33831280c8768e98",
         arm64_linux:  "744690f075f8d4ba1b57bb3d57c893a9a7ca77ade6ef903924847a700ddc42a3",
         x86_64_linux: "4e027a510ef37222caa17ce6db00583d6891924aae5fa7756be6bd64fcf3013b"

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

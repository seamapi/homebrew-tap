cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.40.0"
  sha256 arm:          "56c3594dde90f898c0281efbf047712faf95a10ede5919c85fa7e96714d405b7",
         intel:        "7113ca677e695381d744d625bfc2d8e53f88847ba9afec27d94bbd9d1e7e29b0",
         arm64_linux:  "1cae732e6aa9936e0028cdc94dea70d9ea15de6990ff6d8978cf83dd41bd206f",
         x86_64_linux: "a15897c69321464e28f7312a5ea0236a69c08102d8de7713edf66d0e06c9d9f9"

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

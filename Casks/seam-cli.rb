cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.49.0"
  sha256 arm:          "113c5cbe01302eb72a11236c778183df4cf30201011a9eef60fc55fb3b3cac9b",
         intel:        "28ad17ae71b631aa488b16639b71506afcaec9de9795f2631bca83847d370dc1",
         arm64_linux:  "88c91a18eab6f76bbe1f461e34a3a2355ad13c69127c8b5db541d197478770a4",
         x86_64_linux: "b736e11145fbb05e0ab575499bbd954c0b65149f6fa33d9d607e12e69f48208b"

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

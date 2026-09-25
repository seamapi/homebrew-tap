cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.43.0"
  sha256 arm:          "b5ecc8d6feb012284889f5d75df49eeb5b52107faaa072d7e61419d055fa97b0",
         intel:        "8d83af549ddee32a5447298a9e943d5a7199b0448bea41b286ad6866b1d7e747",
         arm64_linux:  "b057a419d47d3c1cf16f04855eb1baa39066ed048cffb7cfd6657b787de4e281",
         x86_64_linux: "2d3ba61d20df637a08f5da6f931619ae8f308db7aa9ca63ef9445ee87e631e14"

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

cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.33.0"
  sha256 arm:          "ca9e4e56ed1261f3c8048d09d519cdb9d915db967d500e5a1d11d83a21182fbb",
         intel:        "824b48db1e2e235d4550af05ad39c759e19eff2f0a7256eeafb921889e94a152",
         arm64_linux:  "afa02fcb5df90f353c3591b8dd0294771599650ff6a2cb8f1f8ec91c417834be",
         x86_64_linux: "fd4f851f37a972032d6e5fbbca8ba26d6a3d8542e10162d66cf8d248a06189a3"

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

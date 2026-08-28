cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.37.0"
  sha256 arm:          "91ca5a35c310f8f9700d118c2959684e304bb4b5d09fb3373d6b25b12f8ba678",
         intel:        "60fbd42a8f258e29346aed0be998388b1143d13a2b2f6a75c12e484094c9ee06",
         arm64_linux:  "854bdcb2a5a1ca5dd41d2ef94f119f39e7913b4a2a35b32f85ee6888d7698ec6",
         x86_64_linux: "d069616f330225269978133246bf47e5a0e0eef53d230e1e27a82dd137dbc3a6"

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

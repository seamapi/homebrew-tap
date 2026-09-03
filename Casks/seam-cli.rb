cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.38.0"
  sha256 arm:          "e57461796bde1f1161735833faeb9bca3c907f8dc2ccad8a6c74425032855565",
         intel:        "db96153c6c478752a83e510fa74aa998837452f28dfc4e10c4c8b3f16da56d98",
         arm64_linux:  "b8c2a98a299891181d61f295fbfa4a98178a98d496b071d1ccf25ae5dd8ac0c3",
         x86_64_linux: "6175e1a17b4b2e483caf5267d4c5f2b4eb9e29eebe8ff377328f0527ffe8164c"

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

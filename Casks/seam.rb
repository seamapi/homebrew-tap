cask "seam" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.24.1"
  sha256 arm:          "bc29a95fe0c38c1d521127fb515d9a77ad6b4dae9be596fe959ef6ee6be587f2",
         intel:        "187e04f6cb003f1c1ae9d9dbaa1ff0c0d6d202ee3abce22c172f87b051417c37",
         arm64_linux:  "aba1556d8af3fe74a0eaaf64ae7a423fb545803e3c47e24dd44da114773de920",
         x86_64_linux: "6ab3c7c56e88fa25ba0007d98023149eab33e0586032be212194682ae5083393"

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
  resource "completions" do
    url "https://github.com/seamapi/cli/releases/download/v#{version}/seam-completions-v#{version}.tar.gz"
    sha256 "40b2acd6216ee4e8c4b3421d05669d0f5f2589e24795fd8a2d0ae3542b80ec51"
  end

  bash_completion "completions/seam.bash", target: "seam"
  fish_completion "completions/seam.fish"
  zsh_completion "completions/seam.zsh", target: "_seam"
end

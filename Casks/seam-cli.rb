cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.34.0"
  sha256 arm:          "e5e7642cafc30b55504bd6c95b1e6262dabb987b3335371b7ab973854bbb06eb",
         intel:        "76553e1bf00574f9ec81902f6cdc2a49733582ba94bdf7a304e48392bc6571c2",
         arm64_linux:  "b8b4d3dc6015d9f59ac1f1f7e0405ac803d8f5ab140731b1cab31b9f4b435fca",
         x86_64_linux: "2c772847410a54ac5d59216d2ad87432d75a29030bc10a656ea7b1a4b4d2e115"

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

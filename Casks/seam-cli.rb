cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.28.0"
  sha256 arm:          "5c378c364b49a32a3bd2162d276f72874cd34973ae9dc30da00ce8c0e94944b2",
         intel:        "3d672a2b1f13ccb6721496ebd17d58f38cefc96096c0a8d87678644f19c75d8f",
         arm64_linux:  "61edbac099c928fb573b55303522aaea15dc3385f75c3870de5ea19855260aac",
         x86_64_linux: "6516ee96d7fe06a3c8a69527efa696268951d0d8c15ef753ba8c76941a89bf48"

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

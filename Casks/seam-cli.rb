cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.35.0"
  sha256 arm:          "03fe8f07aeab291db190d9f1abc51bdfb3c80859d7478f725109580ee642846f",
         intel:        "452175cbe46c3c186e17bc47d534701af600b70deb9a96fd6acff8934ca68528",
         arm64_linux:  "954681e5d1b67973810697e23e8bd9fd6cafeeec91dad241571c2152f1ae6c92",
         x86_64_linux: "1f9acb585453d9433cb510a92b74e725a2e48a9355c133d91e6996313d7d8c32"

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

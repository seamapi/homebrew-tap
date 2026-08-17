cask "seam" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.26.0"
  sha256 arm:          "f9c8b9830572fb3187797011895c235237c8e790f46eb7028494371f60154853",
         intel:        "5acdfaaec99dce7cdfa9839522166d5b2a5da02448e2b87cb272567e530aca69",
         arm64_linux:  "090587261164faa5a14885418f38deecb1302b7e0f1deaa2cec7c1ade5f55733",
         x86_64_linux: "fd657c0677f859d471bd3b56895e10db1db25868968c4145645f271eafbbf2d1"

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
                                       base_name: "seam"
end

cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.47.0"
  sha256 arm:          "c4ba793a6d50204285e5b7622c6e7d8c9b4e4a220fdfc66cd717e30c4396b947",
         intel:        "c0074b1e96afeb668efdc50b8fcce2f125037a4809aad786fddf237fa0c4c275",
         arm64_linux:  "6ad7d8607e511a7d52c660466970cd8c3a40f3fe2d7c0f33a8a93a127ec2e3dd",
         x86_64_linux: "a0b0f2f33d7f99600ffe160a17b490a628352299ad003cae5efed2d3c17af69d"

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

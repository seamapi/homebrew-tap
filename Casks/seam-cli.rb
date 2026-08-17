cask "seam-cli" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.27.1"
  sha256 arm:          "c765a255fb16f7e05ad0c2048ee1607076e131ef54f1d7e659ba405aaf7644bf",
         intel:        "ea52b279f5a978bee2584ee64ca6f0bd5d4d1f25d7689f9c71bd136ad275af22",
         arm64_linux:  "c63be03d09a9ffea345c319bf62628af230109aea95935d66d50f65afc11090c",
         x86_64_linux: "20bb5e8959cb2eae6350b1d42b120cc2197534a2fa8055e9fd221edbdce7637c"

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
  def caveats
    <<~EOS
      Shell completions are installed.

      zsh:
        If your zsh configuration does not already initialize completions,
        add the following to ~/.zshrc:

          autoload -Uz compinit
          compinit

      bash:
        Ensure bash-completion is installed and initialized.

      fish:
        No additional setup is required.
    EOS
  end
end

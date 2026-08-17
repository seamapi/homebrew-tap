# Seamapi Tap

## How do I install the Seam CLI cask?

```sh
brew uninstall --cask seam # if installed as a Homebrew cask
brew install --cask seamapi/tap/seam-cli
```

Or tap the repository first and install the cask by name:

```sh
brew uninstall --cask seam # if installed as a Homebrew cask
brew tap seamapi/tap
brew install --cask seam-cli
```

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "seamapi/tap"
cask "seam-cli"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

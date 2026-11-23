# 0x96f Forge

## Install

```sh
brew install --cask 0x96f/forge/justty
brew install --cask 0x96f/forge/bitty
```

Justty is publicly downloadable. Bitty downloads require a GitHub CLI login
with read access to `0x96f/bitty-releases`. You can also set
`HOMEBREW_GITHUB_API_TOKEN` to a fine-grained token with Contents read access to
that repository when installing or upgrading.

After tapping `0x96f/forge` and trusting the cask you want to install, you can
use its short name, such as `brew install --cask justty`.

## Release updates

Each app's release workflow updates its file in `Casks/`. Configure
`HOMEBREW_TAP_TOKEN` in each app repository with Contents read and write access
to this tap.

Bitty's source repository is private. Its release workflow publishes the ZIP to
`0x96f/bitty-releases`, which the cask downloads from.

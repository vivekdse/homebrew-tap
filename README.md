# vivekdse/homebrew-tap

Personal Homebrew tap. Currently hosts:

| Cask | What | Source |
|---|---|---|
| `breezefile` | Cross-platform ranger-inspired file manager with native drag-out (macOS) | [vivekdse/breezefile](https://github.com/vivekdse/breezefile) |

## Install

```sh
brew tap vivekdse/tap
brew install --cask breezefile
```

## Notes

The casks here are **unsigned** macOS apps. Each cask uses a `preflight`
block to strip the quarantine attribute so Gatekeeper doesn't block
first launch.

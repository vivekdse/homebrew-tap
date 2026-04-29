# Homebrew cask template for Breeze File. After each release, regenerate
# with the real version + sha256 (from release/shasums.txt) and commit to
# the tap repo (vivekdse/homebrew-tap → Casks/breezefile.rb).
#
#   0.1.15  — semver from the release tag (e.g. 0.1.0)
#   9a4fbbccec760c5c6b7ac6a3364ab17e32882878c6aa46456ab6501c9f1c0827 — sha256 of the arm64 dmg from shasums.txt
#   34223797f0cb9c99bfd3c0aa5711bbcda57e8d9440128d8918cb1dde433cfae3   — sha256 of the x64 dmg from shasums.txt
#
# `xattr -cr` in preflight strips the macOS quarantine bit so Gatekeeper
# doesn't block launch of the unsigned app.

cask "breezefile" do
  arch arm: "arm64", intel: "x64"

  version "0.1.15"
  sha256 arm:   "9a4fbbccec760c5c6b7ac6a3364ab17e32882878c6aa46456ab6501c9f1c0827",
         intel: "34223797f0cb9c99bfd3c0aa5711bbcda57e8d9440128d8918cb1dde433cfae3"

  url "https://github.com/vivekdse/breezefile/releases/download/v#{version}/Breezefile-#{version}-#{arch}.dmg"
  name "Breeze File"
  desc "Cross-platform ranger-inspired file manager with native drag-out"
  homepage "https://github.com/vivekdse/breezefile"

  depends_on macos: ">= :big_sur"

  app "Breeze File.app"

  # Unsigned app — strip the macOS quarantine bit so Gatekeeper doesn't
  # block first launch. See: https://docs.brew.sh/Cask-Cookbook
  preflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{staged_path}/Breeze File.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Breeze File",
    "~/Library/Preferences/com.vivek.breezefile.plist",
    "~/Library/Saved Application State/com.vivek.breezefile.savedState",
  ]
end

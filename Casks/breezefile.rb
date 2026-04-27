# Homebrew cask template for Breeze File. After each release, regenerate
# with the real version + sha256 (from release/shasums.txt) and commit to
# the tap repo (vivekdse/homebrew-tap → Casks/breezefile.rb).
#
#   0.1.11  — semver from the release tag (e.g. 0.1.0)
#   c3e54c98f1d81c64b4b4197dd4d088c4ce01bfcdb1829bfbc3854404366d3139 — sha256 of the arm64 dmg from shasums.txt
#   ff9532940842bbbe988f5a741edde3c1c6aeafc2777525ddeca79b1b37cc6713   — sha256 of the x64 dmg from shasums.txt
#
# `xattr -cr` in preflight strips the macOS quarantine bit so Gatekeeper
# doesn't block launch of the unsigned app.

cask "breezefile" do
  arch arm: "arm64", intel: "x64"

  version "0.1.11"
  sha256 arm:   "c3e54c98f1d81c64b4b4197dd4d088c4ce01bfcdb1829bfbc3854404366d3139",
         intel: "ff9532940842bbbe988f5a741edde3c1c6aeafc2777525ddeca79b1b37cc6713"

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

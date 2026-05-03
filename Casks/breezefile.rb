# Homebrew cask template for Breeze File. After each release, regenerate
# with the real version + sha256 (from release/shasums.txt) and commit to
# the tap repo (vivekdse/homebrew-tap → Casks/breezefile.rb).
#
#   0.1.19  — semver from the release tag (e.g. 0.1.0)
#   9e86be209aea33967b249382c9490d3879f452e00aeef0b2a90ba5e0cdc1be0e — sha256 of the arm64 dmg from shasums.txt
#   1c5f0844c5d679ab8763d04fa1359e8d1b4840a42fe059445f0cef96293fc89e   — sha256 of the x64 dmg from shasums.txt
#
# `xattr -cr` in preflight strips the macOS quarantine bit so Gatekeeper
# doesn't block launch of the unsigned app.

cask "breezefile" do
  arch arm: "arm64", intel: "x64"

  version "0.1.19"
  sha256 arm:   "9e86be209aea33967b249382c9490d3879f452e00aeef0b2a90ba5e0cdc1be0e",
         intel: "1c5f0844c5d679ab8763d04fa1359e8d1b4840a42fe059445f0cef96293fc89e"

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

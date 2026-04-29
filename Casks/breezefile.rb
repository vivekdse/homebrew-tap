# Homebrew cask template for Breeze File. After each release, regenerate
# with the real version + sha256 (from release/shasums.txt) and commit to
# the tap repo (vivekdse/homebrew-tap → Casks/breezefile.rb).
#
#   0.1.18  — semver from the release tag (e.g. 0.1.0)
#   130b7dd3730418afa827e1283279f15d2037df87bef5970c8c5e68664d1502b6 — sha256 of the arm64 dmg from shasums.txt
#   28faac1a980c58a637f5f49c34538030596be153d68f79357d406a9bbd9b8b43   — sha256 of the x64 dmg from shasums.txt
#
# `xattr -cr` in preflight strips the macOS quarantine bit so Gatekeeper
# doesn't block launch of the unsigned app.

cask "breezefile" do
  arch arm: "arm64", intel: "x64"

  version "0.1.18"
  sha256 arm:   "130b7dd3730418afa827e1283279f15d2037df87bef5970c8c5e68664d1502b6",
         intel: "28faac1a980c58a637f5f49c34538030596be153d68f79357d406a9bbd9b8b43"

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

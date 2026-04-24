# Homebrew cask template for Breeze File. After each release, regenerate
# with the real version + sha256 (from release/shasums.txt) and commit to
# the tap repo (vivekdse/homebrew-tap → Casks/breezefile.rb).
#
#   0.1.10  — semver from the release tag (e.g. 0.1.0)
#   4d2da0bc333aee500e751b2488f265a366a0d97d62351645341a6d4f11adbd8a — sha256 of the arm64 dmg from shasums.txt
#   6d7772a9a8a2bb57cea44246e9c1650b5a59e3404a7c6e73628662515b9d55f6   — sha256 of the x64 dmg from shasums.txt
#
# `xattr -cr` in preflight strips the macOS quarantine bit so Gatekeeper
# doesn't block launch of the unsigned app.

cask "breezefile" do
  arch arm: "arm64", intel: "x64"

  version "0.1.10"
  sha256 arm:   "4d2da0bc333aee500e751b2488f265a366a0d97d62351645341a6d4f11adbd8a",
         intel: "6d7772a9a8a2bb57cea44246e9c1650b5a59e3404a7c6e73628662515b9d55f6"

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

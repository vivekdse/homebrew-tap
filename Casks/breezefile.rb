cask "breezefile" do
  arch arm: "arm64", intel: "x64"

  version "0.1.5"
  sha256 arm:   "204af3e606c1a584539e24851e33187621dc71b51933a7a01f4e8ec73f971257",
         intel: "c187570301d0137213bd527075a61fb53671163bc136ca8f442948386aedda7f"

  url "https://github.com/vivekdse/breezefile/releases/download/v#{version}/Breezefile-#{version}-#{arch}.dmg"
  name "Breeze File"
  desc "Cross-platform ranger-inspired file manager with native drag-out"
  homepage "https://github.com/vivekdse/breezefile"

  depends_on macos: ">= :big_sur"

  app "Breeze File.app"

  # Unsigned app — strip the macOS quarantine bit so Gatekeeper doesn't
  # block launch on first run. See https://docs.brew.sh/Cask-Cookbook
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

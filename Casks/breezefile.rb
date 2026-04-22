cask "breezefile" do
  arch arm: "arm64", intel: "x64"

  version "0.1.3"
  sha256 arm:   "17c59c6e4a584373116389a57f4443d4c79796980c066656a52c7cb5a106af0e",
         intel: "80acb1696d21dbc112955e8e7d176ed98eb4f20c627c3cf378d986f6e926c730"

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

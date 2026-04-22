cask "breezefile" do
  arch arm: "arm64", intel: "x64"

  version "0.1.1"
  sha256 arm:   "07bf5b57999441eb0f120630a0d53b6ec6d04b0ca7c3f0b6663f307a50cb4fbf",
         intel: "b93eff22ed6f9de5b1d2dceae9cb3872a072452113cbe4d2a57539486de6612f"

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

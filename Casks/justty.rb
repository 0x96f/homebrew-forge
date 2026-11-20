cask "justty" do
  version "0.9.2"
  sha256 "7884fb0e744d9d38b5ef804887380b1a5cc77902939dc6acfeb0f4487aea874d"

  url "https://github.com/0x96f/justty/releases/download/v#{version}/Justty-macos.zip"
  name "Justty"
  desc "Simple native macOS terminal"
  homepage "https://github.com/0x96f/justty"

  depends_on macos: :sequoia

  app "Justty.app"

  # Self-signed / not notarized — clear Gatekeeper quarantine so first launch works.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Justty.app"]
  end

  zap trash: [
    "~/Library/Preferences/dev.0x96f.justty.plist",
    "~/Library/Saved Application State/dev.0x96f.justty.savedState",
  ]
end

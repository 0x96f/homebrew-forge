cask "bitty" do
  version "0.3.2"
  sha256 "d1be74b5f2e978606f0c98f8299a7de6b3ab2d2d12513866e5fd407e2d011a09"

  url "https://github.com/0x96f/bitty-releases/releases/download/v#{version}/Bitty-macos.zip"
  name "Bitty"
  desc "A tiny terminal that does just enough"
  homepage "https://github.com/0x96f/bitty-releases"

  depends_on macos: :sequoia

  app "Bitty.app"

  # Match Justty's first-launch handling for the self-signed bundle.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Bitty.app"]
  end

  zap trash: [
    "~/Library/Preferences/dev.0x96f.bitty.plist",
    "~/Library/Saved Application State/dev.0x96f.bitty.savedState",
  ]
end

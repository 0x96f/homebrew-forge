cask "bitty" do
  version "0.4.3"
  sha256 "520d61911b25ace9ac9d8598ae3b5aca1ba223dda8c87ab0b7d34be5991a0348"

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

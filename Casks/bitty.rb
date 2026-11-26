cask "bitty" do
  version "0.4.2"
  sha256 "dad07d951a7d08203e546b9bfe6ab828ae5acc597800d0c9ecacd31cc30712e4"

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

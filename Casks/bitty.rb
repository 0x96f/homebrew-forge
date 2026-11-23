# Resolve GitHub's private release download through the authenticated asset API.
class BittyReleaseDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    @tag = "v#{version}"
  end

  private

  def resolve_url_basename_time_file_size(_url, timeout: nil)
    token = GitHub::API.credentials
    if token.blank?
      raise CurlDownloadStrategyError.new(url, "Set HOMEBREW_GITHUB_API_TOKEN or authenticate with gh.")
    end

    release = GitHub.get_release("0x96f", "bitty-releases", @tag)
    filename = "Bitty-macos.zip"
    asset = release.fetch("assets").find { |entry| entry.fetch("name") == filename }
    raise CurlDownloadStrategyError.new(url, "#{filename} is missing from #{@tag}.") unless asset

    [
      asset.fetch("url"),
      filename,
      Time.parse(asset.fetch("updated_at")),
      asset.fetch("size"),
      asset.fetch("content_type"),
      false,
    ]
  end

  def _fetch(url:, resolved_url:, timeout:)
    curl_download(
      resolved_url,
      to: temporary_path,
      try_partial: @try_partial,
      timeout: timeout,
      header: [
        "Accept: application/octet-stream",
        "Authorization: Bearer #{GitHub::API.credentials}",
      ],
    )
  end
end

cask "bitty" do
  version "0.3.2"
  sha256 "d1be74b5f2e978606f0c98f8299a7de6b3ab2d2d12513866e5fd407e2d011a09"

  url "https://github.com/0x96f/bitty-releases/releases/download/v#{version}/Bitty-macos.zip",
      using: BittyReleaseDownloadStrategy
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

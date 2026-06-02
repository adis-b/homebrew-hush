cask "hush" do
  version "1.0.2"
  sha256 "178088a998952c1ff988470cc602ead03ed20cf0540f69b6a0278fd77d96330b"

  url "https://github.com/adis-b/hush/releases/download/v#{version}/Hush-#{version}.dmg"
  name "Hush"
  desc "Menu bar app that closes apps you're not using"
  homepage "https://github.com/adis-b/hush"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-beta)?)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map { |r| r["tag_name"]&.match(regex)&.[](1) }
    end
  end

  depends_on macos: :ventura

  app "Hush.app"

  zap trash: [
    "~/Library/Application Scripts/com.MagicQuit",
    "~/Library/Containers/com.MagicQuit",
    "~/Library/Preferences/com.MagicQuit.plist",
    "~/Library/Saved Application State/com.MagicQuit.savedState",
  ]

  caveats <<~EOS
    Hush is signed ad-hoc, not notarized with a Developer ID. On first launch
    macOS will refuse to open it. Right-click Hush in Applications, choose
    Open, then confirm in the dialog. After that it launches normally.
  EOS
end

cask "cursor" do
  arch arm: "arm64", intel: "x64"

  version "0.47.5,53d6da1322f934a1058e7569ee0847b24879d18c"
  sha256 arm:   "dcf93c70dee13534beb7e504a96f58794940122c664ffe1fa3673594fe5c8dcc",
         intel: "2b6f30e1514c6fbb5692f11cf3c3340ba126ab4c0973905b4d54452ce35188f7"

  url "https://anysphere-binaries.s3.us-east-1.amazonaws.com/production/#{version.csv.second}/darwin/#{arch}/Cursor-darwin-#{arch}.zip",
      verified: "anysphere-binaries.s3.us-east-1.amazonaws.com/"
  name "Cursor"
  desc "Write, edit, and chat about your code with AI"
  homepage "https://www.cursor.com/"

  livecheck do
    url "https://api2.cursor.sh/updates/api/update/darwin-#{arch}/cursor/0.0.0/"
    regex(%r{/production/(\h+)/darwin/#{arch}/Cursor[._-]darwin[._-]#{arch}\.zip}i)
    strategy :json do |json, regex|
      match = json["url"]&.match(regex)
      next if match.blank?

      "#{json["name"]},#{match[1]}"
    end
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  app "Cursor.app"
  binary "#{appdir}/Cursor.app/Contents/Resources/app/bin/code", target: "cursor"

  zap trash: [
    "~/.cursor",
    "~/.cursor-tutor",
    "~/Library/Application Support/Caches/cursor-updater",
    "~/Library/Application Support/Cursor",
    "~/Library/Caches/com.todesktop.*",
    "~/Library/Caches/com.todesktop.*.ShipIt",
    "~/Library/HTTPStorages/com.todesktop.*",
    "~/Library/Logs/Cursor",
    "~/Library/Preferences/ByHost/com.todesktop.*.ShipIt.*.plist",
    "~/Library/Preferences/com.todesktop.*.plist",
    "~/Library/Saved Application State/com.todesktop.*.savedState",
    "~/Library/Saved Application State/todesktop.com.ToDesktop-Installer.savedState",
  ]
end

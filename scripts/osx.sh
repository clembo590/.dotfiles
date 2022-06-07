setup_osx() {
  info "Configuring MacOS default settings"

  # Wipe all (default) app icons from the Dock
  defaults write com.apple.dock persistent-apps -array

for dockItem in {/System/Applications/System\ Preferences,/System/Applications/Utilities/Terminal,/Applications/{"Visual Studio Code","Google Chrome"}}.app; do
  defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>'$dockItem'</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
done

  # Don’t show recent applications in Dock
  defaults write com.apple.dock show-recents -bool false

  # shrinking the Icons of Launchpad
 defaults write com.apple.Dock springboard-rows -int 10
 defaults write com.apple.Dock springboard-columns -int 10

  # force mouse scroll wheel on the correct direction
  defaults write -g com.apple.swipescrolldirection -bool false
  
  # Disable prompting to use new exteral drives as Time Machine volume
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

  # Set weekly software update checks
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 7

  # Secondary click in external mouse
  defaults write com.apple.AppleMultitouchMouse MouseButtonMode -string "TwoButton"

  # have a fast mouse
  defaults write -g com.apple.mouse.scaling -float 3

  # have a fast trackpad
  defaults write -g com.apple.trackpad.scaling -float 3


  # Disable automatic capitalization as it’s annoying when typing code
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  # Disable smart dashes as they’re annoying when typing code
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution as it’s annoying when typing code
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable smart quotes as they’re annoying when typing code
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  

  # Trackpad: enable tap to click for this user and for the login screen
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true


  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
  defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0


  # Keep the Spaces arrangement
  defaults write com.apple.dock "mru-spaces" -bool false

  defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool true

  # Set a blazingly fast keyboard repeat rate
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 10

  # Show language menu in the top right corner of the boot screen
  sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

  # Stop iTunes from responding to the keyboard media keys
  launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

  # show bluetooth in menu bar
  defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
  defaults -currentHost write com.apple.controlcenter Bluetooth -int 18
  
  # show sound in menu bar
  defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true
  defaults -currentHost write com.apple.controlcenter Sound -int 18


  # shortcuts for all the different desktops

  defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 118 "
  		<dict>
			<key>enabled</key>
			<true/>
			<key>value</key>
			<dict>
				<key>parameters</key>
				<array>
					<integer>65535</integer>
					<integer>18</integer>
					<integer>262144</integer>
				</array>
				<key>type</key>
				<string>standard</string>
			</dict>
		</dict>
"

  defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 119 "
		<dict>
			<key>enabled</key>
			<true/>
			<key>value</key>
			<dict>
				<key>parameters</key>
				<array>
					<integer>65535</integer>
					<integer>19</integer>
					<integer>262144</integer>
				</array>
				<key>type</key>
				<string>standard</string>
			</dict>
		</dict>
"
 
  defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 120 "
		<dict>
			<key>enabled</key>
			<true/>
			<key>value</key>
			<dict>
				<key>parameters</key>
				<array>
					<integer>65535</integer>
					<integer>20</integer>
					<integer>262144</integer>
				</array>
				<key>type</key>
				<string>standard</string>
			</dict>
		</dict>
"


 
  defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 121 "
		<dict>
			<key>enabled</key>
			<true/>
			<key>value</key>
			<dict>
				<key>parameters</key>
				<array>
					<integer>65535</integer>
					<integer>21</integer>
					<integer>262144</integer>
				</array>
				<key>type</key>
				<string>standard</string>
			</dict>
		</dict>
"


 
  defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 122 "
		<dict>
			<key>enabled</key>
			<true/>
			<key>value</key>
			<dict>
				<key>parameters</key>
				<array>
					<integer>65535</integer>
					<integer>23</integer>
					<integer>262144</integer>
				</array>
				<key>type</key>
				<string>standard</string>
			</dict>
		</dict>
"

 
  defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 123 "
		<dict>
			<key>enabled</key>
			<true/>
			<key>value</key>
			<dict>
				<key>parameters</key>
				<array>
					<integer>65535</integer>
					<integer>22</integer>
					<integer>262144</integer>
				</array>
				<key>type</key>
				<string>standard</string>
			</dict>
		</dict>
"

  defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 124 "
		<dict>
			<key>enabled</key>
			<true/>
			<key>value</key>
			<dict>
				<key>parameters</key>
				<array>
					<integer>65535</integer>
					<integer>26</integer>
					<integer>262144</integer>
				</array>
				<key>type</key>
				<string>standard</string>
			</dict>
		</dict>
"


  defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 125 "
		<dict>
			<key>enabled</key>
			<true/>
			<key>value</key>
			<dict>
				<key>parameters</key>
				<array>
					<integer>65535</integer>
					<integer>28</integer>
					<integer>262144</integer>
				</array>
				<key>type</key>
				<string>standard</string>
			</dict>
		</dict>
"


# this is to enable launchpad with command + option + ctrl + up
  defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 160 "
		<dict>
			<key>enabled</key>
			<true/>
			<key>value</key>
			<dict>
				<key>parameters</key>
				<array>
					<integer>65535</integer>
					<integer>126</integer>
					<integer>12320768</integer>
				</array>
				<key>type</key>
				<string>standard</string>
			</dict>
		</dict>
"







###############################################################################
# Energy saving                                                               #
###############################################################################

  # Enable lid wakeup
  sudo pmset -a lidwake 1

  # Restart automatically on power loss
  sudo pmset -a autorestart 1

  # Restart automatically if the computer freezes
  sudo systemsetup -setrestartfreeze on

  # Sleep the display after 15 minutes
  #sudo pmset -a displaysleep 15

  # Disable machine sleep while charging
  sudo pmset -c sleep 0

  # Set machine sleep to 5 minutes on battery
  sudo pmset -b sleep 5

  # Set standby delay to 24 hours (default is 1 hour)
  sudo pmset -a standbydelay 86400

  # Never go into computer sleep mode
  sudo systemsetup -setcomputersleep Off > /dev/null




###############################################################################
# Finder                                                                      #
###############################################################################
  # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
  defaults write com.apple.finder QuitMenuItem -bool true

  # Finder: disable window animations and Get Info animations
  defaults write com.apple.finder DisableAllAnimations -bool true

  # Show icons for hard drives, servers, and removable media on the desktop
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

  # Finder: show hidden files by default
  defaults write com.apple.finder AppleShowAllFiles -bool true

  # Finder: show all filename extensions
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Finder: show status bar
  defaults write com.apple.finder ShowStatusBar -bool true

  # Finder: show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # Display full POSIX path as Finder window title
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  # Keep folders on top when sorting by name
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  # When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"


  # Automatically open a new Finder window when a volume is mounted
  defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
  defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
  defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true


  # Avoid creating .DS_Store files on network or USB volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
}

# Set fast keyboard repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Enable trackpad clicking and three-finger drag
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Add US English keyboard
defaults write -g AppleKeyboardLayouts -array-add '("com.apple.keylayout.US")'

# Add Latin America keyboard
defaults write -g AppleKeyboardLayouts -array-add '("org.sil.ukelele.keyboard.LatinAmerican")'

# Set US English as default
defaults write ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources -array-add '{ InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = "com.apple.keylayout.US"; }'

#Default Google Chrome as Browser (Should be installed)
defaults write com.apple.LaunchServices/com.apple.launchservices.secure.plist LSHandlers -array-add '{LSHandlerContentType= "public.html";LSHandlerRoleAll= "com.google.chrome";}'

# Hide and Show The Dock
defaults write com.apple.dock autohide -bool true && defaults write com.apple.dock autohide-time-modifier -float 0.1 && defaults write com.apple.dock autohide-delay -float 0 && defaults write com.apple.dock autohide-fullscreen-delayed -bool false && defaults write com.apple.dock tilesize -int 80

# Show all files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool TRUE

# Use keyboard navigation to move focus between controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Fn key for change keyboard input language
defaults write -g com.apple.keyboard.fnState -bool true

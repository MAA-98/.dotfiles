#!/bin/zsh

# Script for debloating before installing tools:
#- Safely deletes a few default apps (GarageBand, Keynote, Numbers, iMovie), but not Pages
#- Deletes large audio files possibly still around from GarageBand
#- Turns down Spotlight to only applications and directories
#- Turns off Spotlight Suggestions
#- Turns off recent apps in Dock
#- Auto hiding Dock, no delay and setting show animation to be quicker.

# Bloatware apps not part of system to be deleted:
BLOAT_APPS=(
  "/Applications/GarageBand.app"
  "/Applications/Keynote.app"
  "/Applications/Numbers.app"
  "/Applications/iMovie.app"
)
for app in "${BLOAT_APPS[@]}"; do
  if [ -d "$app" ]; then
    echo "Deleting $app ..."
    sudo rm -rf "$app"
    if [ $? -eq 0 ]; then
      echo "$app deleted successfully."
    else
      echo "Failed to delete $app."
    fi
  else
    echo "$app not found to delete, so skipping."
  fi
done

echo "Default app deletion process complete."

# Deleting some files for GarageBand and Logic which are large and could be still be around
echo "Removing GarageBand audio content..."
sudo rm -rf "/Library/Application Support/GarageBand"
sudo rm -rf "/Library/Application Support/Logic"
sudo rm -rf "/Library/Audio/Apple Loops"
echo "GarageBand audio content removed."

# Only allow Spotlight for apps and directories
echo "Disabling Spotlight indexing, except for applications and directories."
defaults write com.apple.Spotlight orderedItems -array \
'{"enabled"=1;"name"="APPLICATIONS";}' \
'{"enabled"=0;"name"="SYSTEM_PREFS";}' \
'{"enabled"=0;"name"="DOCUMENTS";}' \
'{"enabled"=1;"name"="DIRECTORIES";}' \
'{"enabled"=0;"name"="PDF";}' \
'{"enabled"=0;"name"="FONTS";}' \
'{"enabled"=0;"name"="MESSAGES";}' \
'{"enabled"=0;"name"="CONTACT";}' \
'{"enabled"=0;"name"="EVENT_TODO";}' \
'{"enabled"=0;"name"="IMAGES";}' \
'{"enabled"=0;"name"="BOOKMARKS";}' \
'{"enabled"=0;"name"="MUSIC";}' \
'{"enabled"=0;"name"="MOVIES";}' \
'{"enabled"=0;"name"="PRESENTATIONS";}' \
'{"enabled"=0;"name"="SPREADSHEETS";}' \
'{"enabled"=0;"name"="SOURCE";}' \
'{"enabled"=0;"name"="MENU_DEFINITION";}' \
'{"enabled"=0;"name"="MENU_OTHER";}' \
'{"enabled"=0;"name"="MENU_CONVERSION";}' \
'{"enabled"=0;"name"="MENU_EXPRESSION";}' \
'{"enabled"=0;"name"="MENU_WEBSEARCH";}' \
'{"enabled"=0;"name"="MENU_SPOTLIGHT_SUGGESTIONS";}'

# Get rid of Suggestions
echo "Turning off Spotlight Suggestions."
defaults write com.apple.SpotlightSuggestions.plist SuggestionsEnabled -bool false
defaults write com.apple.SpotlightSuggestions.plist ContentSources -array

echo "Restarting Spotlight indexing daemon..."
sudo mdutil -E /
sudo killall mds
echo "Done."

# Get rid of recent apps in the Dock
echo "Disabling recent apps in Dock..."
# Set show-recents to false
defaults write com.apple.dock show-recents -bool false
# Restart the Dock to apply changes
killall Dock
echo "Recent apps in Dock have been disabled and Dock has been restarted."

echo "Auto hiding Dock, no delay and setting show animation to be quicker."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.1
killall Dock
echo "Dock has been restarted. Should be hiding and showing quicker."

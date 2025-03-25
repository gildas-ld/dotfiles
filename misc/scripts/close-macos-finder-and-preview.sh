#!/bin/sh
# Close all Finder and Preview using AppleScript

osascript -e 'tell application "Finder" to close every window' -e 'tell application "Finder" to quit'
osascript -e 'tell application "Preview" to close every window' -e 'tell application "Preview" to quit'

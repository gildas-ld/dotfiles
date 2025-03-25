#!/bin/bash

# Désactive les animations du Dock
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock minimize-to-application -bool true

# Désactive les animations des fenêtres
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Désactive les animations de Mission Control
defaults write com.apple.dock expose-animation-duration -float 0.1

# Réduit les effets visuels (transparence, etc.)
defaults write com.apple.universalaccess reduceTransparency -bool true
defaults write com.apple.universalaccess reduceMotion -bool true

# Désactive le tableau de bord
defaults write com.apple.dashboard mcx-disabled -bool true

# Garde Spotlight actif, mais limite les catégories indexées
sudo defaults write /System/Library/LaunchDaemons/com.apple.metadata.mds.plist ProgramArguments -array \
	"/usr/libexec/mds" "-n" "-F"

# Met à jour les catégories autorisées dans Spotlight
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "RECENT_DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "DIRECTORIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "PDF";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "OTHER";}'

# Redémarre le service Spotlight
killall mds >/dev/null 2>&1
sudo mdutil -E /
sudo mdutil -i on /

# Désactive les mises à jour automatiques
# sudo softwareupdate --schedule off

# Empêche Photos de s’ouvrir automatiquement
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Désactive Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
launchctl disable "gui/${UID}/com.apple.assistantd"

# Désactive l’indexation de Mail
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Supprime les widgets inutiles du Centre de contrôle
defaults write com.apple.controlcenter "NSStatusItem Visible Siri" -bool false

# Arrête les services iCloud inutiles
launchctl unload -w /System/Library/LaunchAgents/com.apple.CloudPhotosConfiguration.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.icloud.findmydeviced.finder.plist 2>/dev/null

# Nettoie les fichiers de cache utilisateur (à utiliser avec prudence)
rm -rf ~/Library/Caches/*
rm -rf ~/Library/Containers/com.apple.Safari/Data/Library/Caches/*
rm -rf ~/Library/Logs/*

# Redémarre le Dock et Finder pour appliquer les changements
killall Dock
killall Finder

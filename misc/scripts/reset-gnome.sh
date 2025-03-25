#!/bin/bash

# Function to safely reset a gsettings key if the schema and key exist
reset_if_exists() {
	local schema="$1"
	local key="$2"
	if gsettings list-schemas | grep -q "$schema"; then
		if gsettings list-keys "$schema" | grep -q "$key"; then
			gsettings reset "$schema" "$key"
		fi
	fi
}

# Update package list and install gnome-shell-extensions if needed
if ! pacman -Q gnome-shell-extensions &> /dev/null; then
	echo "Installation de gnome-shell-extensions..."
	sudo pacman -Sy --noconfirm gnome-shell-extensions
else
	echo "gnome-shell-extensions déjà installé."
fi

# Enable User Themes extension if available
EXT_UUID="user-theme@gnome-shell-extensions.gcampax.github.com"
if ! gnome-extensions list | grep -q "$EXT_UUID"; then
	echo "Extension 'User Themes' introuvable. Assure-toi qu’elle est bien activée dans GNOME Tweaks après installation."
else
	echo "Activation de l’extension 'User Themes'..."
	gnome-extensions enable "$EXT_UUID"
fi

# Réinitialisation des paramètres GNOME liés à l’apparence
echo "Réinitialisation des paramètres de thème GNOME..."

reset_if_exists org.gnome.desktop.interface gtk-theme
reset_if_exists org.gnome.desktop.interface icon-theme
reset_if_exists org.gnome.desktop.interface cursor-theme

reset_if_exists org.gnome.desktop.interface font-name
reset_if_exists org.gnome.desktop.interface document-font-name
reset_if_exists org.gnome.desktop.interface monospace-font-name

reset_if_exists org.gnome.desktop.wm.preferences theme
reset_if_exists org.gnome.desktop.wm.preferences button-layout
reset_if_exists org.gnome.desktop.wm.preferences titlebar-font

reset_if_exists org.gnome.desktop.background picture-uri
reset_if_exists org.gnome.desktop.screensaver picture-uri

reset_if_exists org.gnome.nautilus.icon-view default-zoom-level

reset_if_exists org.gnome.shell.extensions.user-theme name

echo "Réinitialisation complète effectuée. Redémarre GNOME Shell (Alt+F2 → r → Entrée) si nécessaire."

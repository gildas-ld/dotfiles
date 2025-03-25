#!/bin/bash

echo "🧹 Suppression de PulseAudio..."
pacman -Rns pulseaudio pulsemixer -y

echo "📦 Installation de PipeWire et dépendances audio..."
pacman -Syu --noconfirm \
	pipewire \
	pipewire-alsa \
	pipewire-pulse \
	pipewire-jack \
	wireplumber \
	gst-plugin-pipewire \
	alsa-utils

echo "🎧 Installation du support Bluetooth (optionnel)..."
pacman -Syu --noconfirm bluez bluez-utils

echo "✅ Terminé côté root. Maintenant, exécute le script utilisateur sans sudo."

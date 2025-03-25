#!/bin/bash

echo "🧹 Suppression de PulseAudio et de ses démons s'il en reste..."
sudo pacman -Rns pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulsemixer -y

echo "🧼 Suppression des caches et config utilisateurs..."
rm -rf ~/.config/pipewire ~/.config/wireplumber ~/.pulse ~/.config/pulse ~/.cache/wireplumber

echo "📦 Réinstallation complète de PipeWire + support audio + Bluetooth..."
sudo pacman -Syu --noconfirm \
	pipewire \
	pipewire-audio \
	pipewire-pulse \
	wireplumber \
	pipewire-alsa \
	pipewire-jack \
	pipewire-zeroconf \
	pipewire-v4l2 \
	lib32-pipewire \
	lib32-pipewire-jack \
	lib32-pipewire-alsa \
	lib32-pipewire-audio \
	libspa-bluetooth

echo "🔁 Redémarrage des services utilisateurs PipeWire..."
systemctl --user daemon-reexec
systemctl --user stop pipewire.service pipewire-pulse.service wireplumber.service
systemctl --user start pipewire.service pipewire-pulse.service wireplumber.service

echo "🔒 Activation permanente au démarrage..."
systemctl --user enable pipewire.service pipewire-pulse.service wireplumber.service

echo "✅ PipeWire est maintenant proprement réinstallé et activé."
echo "ℹ️ Redémarre ton PC, puis lance 'wpctl status' ou 'helvum' pour vérifier les flux audio."

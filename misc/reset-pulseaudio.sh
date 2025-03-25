#!/bin/bash

# Reset PulseAudio and remove PipeWire completely on Arch Linux
# WARNING: This will stop audio temporarily and modify system configs

set -e

echo "Stopping audio-related services..."

# Stop user services
systemctl --user stop pipewire.service pipewire.socket pipewire-pulse.service pipewire-pulse.socket
systemctl --user disable pipewire.service pipewire.socket pipewire-pulse.service pipewire-pulse.socket || true

# Stop and disable WirePlumber
systemctl --user stop wireplumber.service
systemctl --user disable wireplumber.service || true

echo "Removing PipeWire and related packages..."
# Remove PipeWire and related packages
sudo pacman -Rns --noconfirm pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber

echo "Cleaning PipeWire configuration files..."

# Delete user PipeWire configuration
rm -rf ~/.config/pipewire ~/.local/state/pipewire ~/.cache/pipewire

# Delete system-wide PipeWire configuration if exists
sudo rm -rf /etc/pipewire /usr/share/pipewire

echo "Resetting PulseAudio configuration..."

# Kill PulseAudio if running
pulseaudio --kill || true

# Remove user PulseAudio configuration to reset
rm -rf ~/.config/pulse ~/.pulse

# Restore system configuration from /etc/pulse defaults
sudo cp -r /etc/pulse/default.pa /etc/pulse/system.pa /etc/pulse/daemon.conf /etc/pulse/client.conf /tmp/pulseaudio_backup/

# Optional: Clean system-wide overrides
sudo rm -rf /etc/systemd/user/pipewire* /etc/systemd/user/wireplumber*

echo "Re-enabling PulseAudio systemd services..."

# Enable and start PulseAudio
systemctl --user enable pulseaudio.service pulseaudio.socket
systemctl --user start pulseaudio.service pulseaudio.socket

echo "Pulseaudio reset and PipeWire removed successfully."

echo "You may need to reboot to finalize all changes."

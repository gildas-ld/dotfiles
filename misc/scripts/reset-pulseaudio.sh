#!/bin/bash

set -e

# Kill all PulseAudio processes
echo "Killing all PulseAudio processes..."
pulseaudio -k || true
pkill -9 pulseaudio || true

# Remove user-specific PulseAudio configuration files
echo "Removing user PulseAudio configuration files..."
rm -rf ~/.config/pulse/
rm -rf ~/.pulse/

# Ensure ~/.config/pulse exists
mkdir -p ~/.config/pulse/

# Restore the default.pa configuration from /etc/pulse
echo "Restoring default.pa from /etc/pulse/..."
cp /etc/pulse/default.pa ~/.config/pulse/default.pa

# Reload user systemd services
echo "Reloading systemd user services..."
systemctl --user daemon-reexec
systemctl --user daemon-reload

# Restart PulseAudio
echo "Restarting PulseAudio..."
pulseaudio --start

# Final confirmation message
echo "PulseAudio configuration has been restored from /etc/pulse/default.pa."

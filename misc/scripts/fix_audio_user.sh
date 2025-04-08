#!/bin/bash

echo "🧼 Nettoyage des configurations audio utilisateur..."
rm -rf ~/.config/pipewire ~/.config/wireplumber ~/.pulse ~/.config/pulse ~/.cache/wireplumber

echo "🔄 Redémarrage de PipeWire et WirePlumber..."
systemctl --user daemon-reexec
systemctl --user restart pipewire.service pipewire-pulse.service wireplumber.service

echo "🔒 Activation permanente des services PipeWire..."
systemctl --user enable pipewire.service pipewire-pulse.service wireplumber.service

echo "🎧 Configuration audio PipeWire réinitialisée avec succès !"
echo "👉 Redémarre ton PC, branche les écouteurs, puis lance 'wpctl status' ou 'helvum'."

#!/bin/bash

# Désactive le réveil lors de l'ouverture du capot
pmset -a lidwake 0

# Désactive le réveil par proximité Bluetooth
pmset -a proximitywake 0

# Désactive le maintien de connexion réseau en veille
pmset -a tcpkeepalive 0

# Désactive le réveil lors de la reconnexion à l'alimentation
pmset -a acwake 0

# Désactive Power Nap (pas de tâches de fond réseau en veille)
pmset -a powernap 0

# Configure la machine pour qu'elle entre en veille après 5 minutes d'inactivité
pmset -a sleep 5

# Configure la mise en veille de l'écran après 3 minutes d'inactivité
pmset -a displaysleep 3

# Configure la mise en veille du disque après 10 minutes d'inactivité
pmset -a disksleep 10

# Force l'hibernation complète (mode 25)
pmset -a hibernatemode 25

# Active le standby (veille profonde)
pmset -a standby 1

# Désactive Wake on LAN (évite les réveils réseau)
pmset -a womp 0

# Force le seuil de batterie à 50% avant standby
pmset -a highstandbythreshold 50

# Configure standby rapide après 1 seconde pour batterie faible
pmset -a standbydelaylow 1

# Configure standby rapide après 1 seconde pour batterie élevée
pmset -a standbydelayhigh 1

# Active la réduction de la luminosité écran avant mise en veille
pmset -a halfdim 1

# Empêche le système de se réveiller pour les TTY (terminal) actifs
pmset -a ttyskeepawake 1

# (Optionnel) Configure le basculement GPU automatique (si machine compatible)
pmset -a gpuswitch 2

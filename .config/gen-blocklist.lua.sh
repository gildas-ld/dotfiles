#!/bin/bash

# Définit l'entrée et la sortie
INPUT="/etc/knot-resolver/blocked-hosts.txt"
OUTPUT="/etc/knot-resolver/blocklist.lua"

# Vide le fichier de sortie
echo "-- Fichier généré automatiquement : ne pas modifier à la main" >"$OUTPUT"
echo "local trackers = {" >>"$OUTPUT"

# Extrait les domaines depuis le fichier hosts
grep '^0\.0\.0\.0' "$INPUT" | awk '{print $2}' | sort -u | while read -r domain; do
	echo "    '$domain'," >>"$OUTPUT"
done

echo "}" >>"$OUTPUT"
echo "" >>"$OUTPUT"
echo "-- Applique une règle de blocage DNS pour chaque domaine" >>"$OUTPUT"
echo "for _, domain in ipairs(trackers) do" >>"$OUTPUT"
echo "    policy.add(policy.block(domain))" >>"$OUTPUT"
echo "end" >>"$OUTPUT"

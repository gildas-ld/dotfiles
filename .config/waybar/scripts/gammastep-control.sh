#!/bin/bash

MIN_TEMP=2500
MAX_TEMP=5000
STEP=100
STATE_FILE="/tmp/gammastep_temp"
PID_FILE="/tmp/gammastep_pid"

# Lit la température actuelle ou l'initialise
if [ ! -f "$STATE_FILE" ]; then
	echo "$MAX_TEMP" >"$STATE_FILE"
fi

CURRENT_TEMP=$(cat "$STATE_FILE")

# Gère l'action demandée
case "$1" in
up)
	NEW_TEMP=$((CURRENT_TEMP + STEP))
	if [ "$NEW_TEMP" -gt "$MAX_TEMP" ]; then
		NEW_TEMP=$MAX_TEMP
	fi
	;;
down)
	NEW_TEMP=$((CURRENT_TEMP - STEP))
	if [ "$NEW_TEMP" -lt "$MIN_TEMP" ]; then
		NEW_TEMP=$MIN_TEMP
	fi
	;;
reset)
	pkill -f "gammastep"
	NEW_TEMP=$MAX_TEMP
	;;
*)
	echo "${CURRENT_TEMP}K"
	exit 0
	;;
esac

# Tue l'ancienne instance si elle existe encore
if [ -f "$PID_FILE" ]; then
	OLD_PID=$(cat "$PID_FILE")
	if kill -0 "$OLD_PID" 2>/dev/null; then
		kill "$OLD_PID"
	fi
fi

# Lance la nouvelle instance en arrière-plan
nohup gammastep -O "$NEW_TEMP" >/dev/null 2>&1 &

# Enregistre le PID de cette nouvelle instance
echo $! >"$PID_FILE"

# Met à jour la température
echo "$NEW_TEMP" >"$STATE_FILE"

# Affiche la température actuelle
echo "${NEW_TEMP}K"

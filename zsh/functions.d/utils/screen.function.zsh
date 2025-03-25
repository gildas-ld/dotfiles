#!/usr/bin/env zsh

set_brightness() {
	# Calculates the actual value from the given percentage

	brightness=$(awk -v p="$1" 'BEGIN { print int(500 + (p / 100) * (24000 - 500)) }')

	# Applies calculated brightness to the system
	echo "$brightness" | sudo tee /sys/class/backlight/intel_backlight/brightness
}
get_brightness_percentage() {
	# Reads the current brightness value
	current=$(cat /sys/class/backlight/intel_backlight/brightness)

	# Calculates the corresponding percentage
	awk -v val="$current" 'BEGIN { printf "%.0f\n", ((val - 500) / (24000 - 500)) * 100 }'
}


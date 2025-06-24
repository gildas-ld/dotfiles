#!/bin/bash

# Display GPU diagnostics
# Update the refresh rate (in seconds)
INTERVAL=1

# Function to convert millidegrees Celsius to degrees Celsius
to_celsius() {
	awk '{printf "%.1f°C\n", $1 / 1000}'
}

# Loop to display information at intervals
while true; do
	clear
	echo "===== AMD GPU Diagnostics ====="
	echo ""

	echo "-- Clock & Voltage (OD) --"
	cat /sys/class/drm/card1/device/pp_od_clk_voltage 2> /dev/null || echo "Unavailable"

	echo ""
	echo "-- GPU Utilization --"
	cat /sys/class/drm/card1/device/gpu_busy_percent 2> /dev/null || echo "Unavailable"

	echo ""
	echo "-- GPU Frequency (sclk states) --"
	cat /sys/class/drm/card1/device/pp_dpm_sclk 2> /dev/null || echo "Unavailable"

	echo ""
	echo "-- VRAM Frequency (mclk states) --"
	cat /sys/class/drm/card1/device/pp_dpm_mclk 2> /dev/null || echo "Unavailable"

	echo ""
	echo "-- GPU Temperature --"
	temp_file=$(ls /sys/class/drm/card1/device/hwmon/hwmon*/temp1_input 2> /dev/null | head -n1)
	if [ -n "$temp_file" ]; then
		cat "$temp_file" | to_celsius
	else
		echo "Unavailable"
	fi

	echo ""
	echo "-- VRAM Usage --"
	used=$(cat /sys/class/drm/card1/device/mem_info_vram_used 2> /dev/null)
	total=$(cat /sys/class/drm/card1/device/mem_info_vram_total 2> /dev/null)
	if [ -n "$used" ] && [ -n "$total" ]; then
		used_mb=$((used / 1024 / 1024))
		total_mb=$((total / 1024 / 1024))
		echo "$used_mb MiB / $total_mb MiB"
	else
		echo "Unavailable"
	fi

	echo ""
	echo "-- Power Management Info --"
	cat /sys/kernel/debug/dri/0/amdgpu_pm_info 2> /dev/null || echo "Unavailable"

	sleep $INTERVAL
done

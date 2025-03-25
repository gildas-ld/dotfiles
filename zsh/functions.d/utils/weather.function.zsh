#!/usr/bin/env zsh

NC="\033[0m"
RED="\033[0;31m"
BOLD="\e[1m"
UNDERLINE="\e[1m"
E_BOLD="\e[22m"
E_UNDERLINE="\e[24m"

#!/bin/bash

NC="\033[0m"
BOLD="\e[1m"
E_BOLD="\e[22m"

getweather() {
	LAT="48.8577668"
	LON="2.3393457"

	# Récupère les données météo depuis l'API Open-Meteo
	weather=$(curl -sf "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=apparent_temperature,precipitation,rain,weather_code&hourly=temperature_1000hPa,dew_point_1000hPa,relative_humidity_1000hPa,cloud_cover_1000hPa&daily=sunrise,sunset,daylight_duration,apparent_temperature_max,apparent_temperature_min,rain_sum,precipitation_sum&forecast_days=1&timezone=auto")

	if [ -n "$weather" ]; then
		# ───── Données actuelles ─────
		apparent_temperature=$(echo "$weather" | jq ".current.apparent_temperature")
		precipitation=$(echo "$weather" | jq ".current.precipitation")
		rain=$(echo "$weather" | jq ".current.rain")
		weather_code=$(echo "$weather" | jq ".current.weather_code")

		echo -e "\n── Données actuelles ──"
		echo "Température ressentie : ${BOLD}${apparent_temperature}°C${E_BOLD}"
		echo "Précipitations : $precipitation mm"
		echo "Pluie : $rain mm"
		echo "Code météo : $weather_code"

		# ───── Données horaires (prochaine heure disponible) ─────
		temp_1000=$(echo "$weather" | jq ".hourly.temperature_1000hPa[0]")
		dew_point_1000=$(echo "$weather" | jq ".hourly.dew_point_1000hPa[0]")
		humidity_1000=$(echo "$weather" | jq ".hourly.relative_humidity_1000hPa[0]")
		cloud_cover_1000=$(echo "$weather" | jq ".hourly.cloud_cover_1000hPa[0]")

		echo -e "\n── Données horaires (prochaine heure disponible) ──"
		echo "Température à 1000hPa : $temp_1000 °C"
		echo "Point de rosée à 1000hPa : $dew_point_1000 °C"
		echo "Humidité relative à 1000hPa : $humidity_1000 %"
		echo "Couverture nuageuse à 1000hPa : $cloud_cover_1000 %"

		# ───── Données journalières (jour 0) ─────
		sunrise=$(echo "$weather" | jq -r ".daily.sunrise[0]" | cut -d'T' -f2)
		sunset=$(echo "$weather" | jq -r ".daily.sunset[0]" | cut -d'T' -f2)
		daylight_duration=$(echo "$weather" | jq ".daily.daylight_duration[0]")

		# Convertit la durée du jour (en secondes) en HH:MM:SS
		day_duration_formatted=$(printf '%02d:%02d:%02d' \
			$((daylight_duration / 3600)) \
			$((daylight_duration % 3600 / 60)) \
			$((daylight_duration % 60)))

		temp_max=$(echo "$weather" | jq ".daily.apparent_temperature_max[0]")
		temp_min=$(echo "$weather" | jq ".daily.apparent_temperature_min[0]")
		rain_sum=$(echo "$weather" | jq ".daily.rain_sum[0]")
		precip_sum=$(echo "$weather" | jq ".daily.precipitation_sum[0]")

		echo -e "\n── Données journalières ──"
		echo "Lever du soleil : $sunrise"
		echo "Coucher du soleil : $sunset"
		echo "Durée du jour : $day_duration_formatted"
		echo "Température ressentie max : $temp_max °C"
		echo "Température ressentie min : $temp_min °C"
		echo "Total pluie : $rain_sum mm"
		echo "Total précipitations : $precip_sum mm"
	fi
}

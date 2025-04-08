#!/usr/bin/env python3

import json
import os
import pandas as pd
import openmeteo_requests
import requests_cache
from retry_requests import retry

# Icônes météo simplifiées pour correspondre aux weather codes d'Open-Meteo
weather_icons = {
    0: "󰖙",  # Clair
    1: "",  # Principalement clair
    2: "",  # Partiellement nuageux
    3: "",  # Couvert
    45: "",  # Brouillard
    48: "",  # Brouillard givrant
    51: "",  # Bruine légère
    53: "",  # Bruine modérée
    55: "",  # Bruine dense
    61: "",  # Pluie légère
    63: "",  # Pluie modérée
    65: "",  # Pluie forte
    71: "",  # Neige légère
    73: "",  # Neige modérée
    75: "",  # Neige forte
    80: "",  # Averses légères
    81: "",  # Averses modérées
    82: "",  # Averses violentes
    "default": "",
}

# Coordonnées GPS
latitude = 48.8577668
longitude = 2.3393457

# Configure la session avec cache et retry
cache_session = requests_cache.CachedSession(".cache", expire_after=3600)
retry_session = retry(cache_session, retries=5, backoff_factor=0.2)
openmeteo = openmeteo_requests.Client(session=retry_session)

# Paramètres pour la requête Open-Meteo
url = "https://api.open-meteo.com/v1/forecast"
params = {
    "latitude": latitude,
    "longitude": longitude,
    "hourly": [
        "temperature_1000hPa",
        "dew_point_1000hPa",
        "relative_humidity_1000hPa",
        "cloud_cover_1000hPa",
    ],
    "daily": [
        "sunrise",
        "sunset",
        "daylight_duration",
        "apparent_temperature_max",
        "apparent_temperature_min",
        "rain_sum",
        "precipitation_sum",
    ],
    "forecast_days": 1,
    "timezone": "auto",
}

# Récupère les données météo
responses = openmeteo.weather_api(url, params=params)
response = responses[0]

# Données horaires
hourly = response.Hourly()
hourly_time = pd.to_datetime(hourly.Time(), unit="s", utc=True)
temperature_1000hPa = hourly.Variables(0).ValuesAsNumpy()
dew_point_1000hPa = hourly.Variables(1).ValuesAsNumpy()
humidity_1000hPa = hourly.Variables(2).ValuesAsNumpy()
cloud_cover_1000hPa = hourly.Variables(3).ValuesAsNumpy()

# Données journalières
daily = response.Daily()
daily_sunrise = pd.to_datetime(daily.Variables(0).Value(), unit="s")
daily_sunset = pd.to_datetime(daily.Variables(1).Value(), unit="s")
daylight_duration = daily.Variables(2).Value()
apparent_temp_max = daily.Variables(3).Value()
apparent_temp_min = daily.Variables(4).Value()
rain_sum = daily.Variables(5).Value()
precip_sum = daily.Variables(6).Value()

# Données pour affichage (utilise la première heure comme exemple)
temp_text = f"{temperature_1000hPa[0]:.0f}°C"
dew_point_text = f"Point de rosée {dew_point_1000hPa[0]:.0f}°C"
humidity_text = f" {humidity_1000hPa[0]:.0f}%"
cloud_text = f"Nuages {cloud_cover_1000hPa[0]:.0f}%"

# Icône météo fictive ici (pas de weather_code fourni dans hourly)
icon = weather_icons.get("default", "")
status = "Prévisions"
status_code = "0"

# Assemble le texte du tooltip
tooltip_text = str.format(
    "\t\t{}\t\t\n{}\n{}\n{}\n{}\n\n🌅 {:%H:%M} 🌇 {:%H:%M} ☀️ {:.0f} min\nMax: {:.0f}°C  Min: {:.0f}°C\n🌧️ {:.1f} mm / {:.1f} mm",
    f'<span size="xx-large">{temp_text}</span>',
    f"<big>{icon}</big>",
    f"<b>{status}</b>",
    dew_point_text,
    humidity_text,
    daily_sunrise,
    daily_sunset,
    daylight_duration / 60,
    apparent_temp_max,
    apparent_temp_min,
    rain_sum,
    precip_sum,
)

# Données à afficher dans Waybar ou autre
out_data = {
    "text": f"{icon}  {temp_text}",
    "alt": status,
    "tooltip": tooltip_text,
    "class": status_code,
}
print(json.dumps(out_data))

# Écrit une version texte simple dans le cache
simple_weather = (
    f"{icon}  {status}\n"
    + f"  {temp_text} ({dew_point_text})\n"
    + f"{humidity_text} | {cloud_text}\n"
    + f"🌅 {daily_sunrise:%H:%M} - 🌇 {daily_sunset:%H:%M} ({daylight_duration/60:.0f} min)\n"
    + f"🌡️ Max {apparent_temp_max:.0f}°C / Min {apparent_temp_min:.0f}°C\n"
    + f"🌧️ Pluie {rain_sum:.1f} mm | Précip. {precip_sum:.1f} mm\n"
)

try:
    with open(os.path.expanduser("~/.cache/.weather_cache"), "w") as file:
        file.write(simple_weather)
except Exception as e:
    print(f"Erreur lors de l’écriture du cache : {e}")

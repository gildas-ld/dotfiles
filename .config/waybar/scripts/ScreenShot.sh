#!/bin/bash

# Screenshot script for Sway

# Set variables
time=$(date "+%d-%b_%H-%M-%S")
dir="$(xdg-user-dir)/Pictures/Screenshots"
file="Screenshot_${time}_${RANDOM}.png"
iDIR="$HOME/.config/swaync/icons"
iDoR="$HOME/.config/swaync/images"
sDIR="$HOME/.config/waybar/scripts"

# Get the name of the active application
active_window_class=$(swaymsg -t get_tree | jq -r '.. | try select(.focused == true).app_id // empty')
[[ -z $active_window_class ]] && active_window_class="unknown"
active_window_file="Screenshot_${time}_${active_window_class}.png"
active_window_path="${dir}/${active_window_file}"

notify_cmd_base="notify-send -t 10000 -A action1=Open -A action2=Delete -h string:x-canonical-private-synchronous:shot-notify"
notify_cmd_shot="${notify_cmd_base} -i ${iDIR}/picture.png "
notify_cmd_shot_win="${notify_cmd_base} -i ${iDIR}/picture.png "
notify_cmd_NOT="notify-send -u low -i ${iDoR}/note.png "

# Show a notification and open the screenshot
notify_view() {
	if [[ $1 == "active" ]]; then
		if [[ -e ${active_window_path} ]]; then
			resp=$(timeout 5 ${notify_cmd_shot_win} " Screenshot of:" " ${active_window_class} Saved.")
			case "$resp" in
			action1) xdg-open "${active_window_path}" &;;
			action2) rm "${active_window_path}" &;;
			esac
		else
			${notify_cmd_NOT} " Screenshot of:" " ${active_window_class} NOT Saved."

		fi
	elif [[ $1 == "swappy" ]]; then
		resp=$(${notify_cmd_shot} " Screenshot:" " Captured by Swappy")
		case "$resp" in
		action1) swappy -f - <"$tmpfile" ;;
		action2) rm "$tmpfile" ;;
		esac
	else
		local check_file="${dir}/${file}"
		if [[ -e $check_file ]]; then
			resp=$(timeout 5 ${notify_cmd_shot} " Screenshot" " Saved")
			case "$resp" in
			action1) xdg-open "${check_file}" &;;
			action2) rm "${check_file}" &;;
			esac
		else
			${notify_cmd_NOT} " Screenshot" " NOT Saved"

		fi
	fi
}

# Show a countdown
countdown() {
	for sec in $(seq $1 -1 1); do
		notify-send -h string:x-canonical-private-synchronous:shot-notify -t 1000 -i "$iDIR"/timer.png " Taking shot" " in: $sec secs"
		sleep 1
	done
}

# Take an immediate screenshot
shotnow() {
	cd ${dir} && grim - | tee "$file" | wl-copy
	sleep 2
	notify_view
}

# Take a screenshot after 5 seconds
shot5() {
	countdown '5'
	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
	sleep 1
	notify_view
}

# Take a screenshot after 10 seconds
shot10() {
	countdown '10'
	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
	notify_view
}

# Take a screenshot of the active window (simulated using `swaymsg`)
shotwin() {
	# Get coordinates and size of the active window
	geom=$(swaymsg -t get_tree | jq -r '    .. | try select(.focused == true) |    "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)"')
	cd ${dir} && grim -g "$geom" - | tee "$file" | wl-copy
	notify_view
}

# Take a screenshot of a selected area
shotarea() {
	tmpfile=$(mktemp)
	grim -g "$(slurp)" - >"$tmpfile"
	# Copy the screenshot if it exists
	if [[ -s $tmpfile ]]; then
		wl-copy <"$tmpfile"
		mv "$tmpfile" "$dir/$file"
	fi
	notify_view
}

# Take a screenshot of the active window with a custom filename
shotactive() {
	active_window_class=$(swaymsg -t get_tree | jq -r '.. | try select(.focused == true).app_id // empty')
	[[ -z $active_window_class ]] && active_window_class="unknown"
	active_window_file="Screenshot_${time}_${active_window_class}.png"
	active_window_path="${dir}/${active_window_file}"
	geom=$(swaymsg -t get_tree | jq -r '    .. | try select(.focused == true) |    "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)"')
	grim -g "$geom" "${active_window_path}"
	sleep 1
	notify_view "active"
}

# Take a screenshot and open in Swappy
shotswappy() {
	tmpfile=$(mktemp)
	grim -g "$(slurp)" - >"$tmpfile"
	# Copy without saving
	if [[ -s $tmpfile ]]; then
		wl-copy <"$tmpfile"
		notify_view "swappy"
	fi
}

# Create the screenshots folder if it does not exist
if [[ ! -d $dir ]]; then
	mkdir -p "$dir"
fi

# Route options
main() {
  if [[ $1 == "--now" ]]; then
    shotnow
  elif [[ $1 == "--in5" ]]; then
    shot5
  elif [[ $1 == "--in10" ]]; then
    shot10
  elif [[ $1 == "--win" ]]; then
    shotwin
  elif [[ $1 == "--area" ]]; then
    shotarea
  elif [[ $1 == "--active" ]]; then
    shotactive
  elif [[ $1 == "--swappy" ]]; then
    shotswappy
  else
    echo -e "Available Options : --now --in5 --in10 --win --area --active --swappy"
  fi
}

# Prevents execution if script is sourced
(return 0 2>/dev/null) && return

# Calls the main function only if the script is executed
main "$@"

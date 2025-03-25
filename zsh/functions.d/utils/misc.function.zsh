#!/usr/bin/env zsh

findcommands() {
	compgen -ac | grep "${1}"
}

sunglasses() {
	echo -en " (•_•)      \r"
	sleep .5
	echo -en " ( •_•)>⌐■-■\r"
	sleep 1
	echo -en " (⌐■_■)     \r"
	sleep 1
	echo -en "YEEEEAAAAAH!\n"
	sleep 1
}

kill_matching_processes() {
    # Check if an argument is provided
    if [ -z "$1" ]; then
        echo "Usage: kill_matching_processes <pattern>"
        return 1
    fi

    # Store the pattern to search
    local pattern="$1"

    # Find and kill matching processes
    ps aux | grep -i -- "$pattern" | grep -v grep | awk '{print $2}' | while read -r pid; do
        # Kill the process
        sudo kill -9 "$pid" 2>/dev/null && echo "Killed process $pid matching pattern '$pattern'"
    done
}


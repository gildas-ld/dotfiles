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

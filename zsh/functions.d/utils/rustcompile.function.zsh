#!/usr/bin/env zsh

NC="\033[0m"
RED="\033[0;31m"
BOLD="\e[1m"
UNDERLINE="\e[1m"
E_BOLD="\e[22m"
E_UNDERLINE="\e[24m"

rurs() {
	rustc "./$1.rs" &&
		mv -f "$1" "$1.bin" 1> /dev/null &&
		"./$1.bin"
	rm -f "./$1.bin" 1> /dev/null
	# && echo "${BOLD}OK${E_BOLD}"
}

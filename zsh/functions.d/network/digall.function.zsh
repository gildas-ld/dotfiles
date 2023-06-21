#!/bin/env zsh
digall() {

	DIGALL_COLOR_RESTORE='\033[0m'
	DIGALL_COLOR_RED='\033[0;31m'
	DIGALL_COLOR_LIGHT_GREEN='\033[1;32m'
	DIGALL_COLOR_LIGHT_BLUE='\033[1;34m'
	DIGALL_COLOR_LIGHT_CYAN='\033[1;36m'

	if [ -z "$1" ]; then
		printf "${DIGALL_COLOR_RED}Error : Pass domain as first arg${DIGALL_COLOR_RESTORE}"
	else
		printf "${DIGALL_COLOR_LIGHT_BLUE}\nQueries : (dig +noall +answer '$1' '<type>')...${DIGALL_COLOR_LIGHT_CYAN}\n\n"

		for t in SOA NS SPF TXT MX AAAA A; do
			printf "${DIGALL_COLOR_LIGHT_GREEN}Querying for $t records...\n${DIGALL_COLOR_RESTORE}${DIGALL_COLOR_LIGHT_CYAN}"
			dig +noall +answer "$1" "${t}"
			printf "${DIGALL_COLOR_RESTORE}"
		done
	fi
}

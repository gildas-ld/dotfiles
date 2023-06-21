#!/usr/bin/zsh

alias clr='clear; echo Currently logged in on $TTY, as $USERNAME in directory $PWD.'
alias path='print -l $path'

function ip() {
	if [ -t 1 ]; then
		command ip -color -all -human "$@"
	else
		command ip -all -human "$@"
	fi
}

function dir-ls() {
	print -l *(/)
}

function psgrep() {
	ps aux | grep "${1:-.}" | grep -v grep
}

# Kills any process that matches a regexp
function killit() {
	ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# Printing process according to the port number
function port-process() {
	netstat -tulpna | grep "${1}" | awk '{print $7}' | cut -d/ -f1
}

# Delete 0 byte file
function delete-0-bytes-files() {
	find "${1:-.}" -type f -size 0 -exec rm -rf {} \;
}

# gather external ip address
function pubip() {
	possibleResolvers=(
		'https://ifcfg.me/json'
		'https://myexternalip.com/json'
		'https://api.ipify.org?format=json'
		'https://ipinfo.io/json'
		'https://ifcfg.me/json'
	)
	while true; do
		resolver=${possibleResolvers[$((RANDOM % ${#possibleResolvers[@]}))]}

		json=$(curl --silent --insecure $resolver 2> /dev/null)

		if [ -n "$json" ]; then
			# ip=$(echo "$json" | jq -r .ip)
			ip=$(echo "$json" | awk -F'"' '/ip/ {print $4}')
			# wholeFetch=$(echo "$json" | jq .)
			wholeFetch="$json"
			if [ -n "$ip" ]; then
				echo $wholeFetch
				break
			fi
		fi
		echo "Retrying..."
		sleep 0.1
	done
}

# determine local IP address(es)
function getIP() {
	ifconfig | awk '/inet /{print $2}' | command grep -v 127.0.0.1
}

# Clear zombie processes
function clear-zombies() {
	ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9
}
function lsofpid() {
	lsof -a -p "${1:-'1'}"
}

function lsofnet() {
	lsof -i -n -P
}

function ssemul() {
	lsof -i -n -P
	netstat -an | grep -E 'Proto|LISTEN'
}

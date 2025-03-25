#!/bin/env zsh

check-ssl() {
	local IP_OR_HOSTNAME="${1}"
	local PORT="${2:-443}"
	local CERT_INFO ISSUER VALID_UNTIL SUBJECT SAN OPENSSL_BIN
	declare -a OPENSSL_BINS=()
	OPENSSL_BIN="/usr/bin/openssl"
	CERT_INFO="$(echo | "${OPENSSL_BIN}" s_client \
		-connect "${IP_OR_HOSTNAME}:${PORT}" 2> /dev/null | "${OPENSSL_BIN}" x509 \
		-noout -text -certopt 'no_header,no_version,no_serial,no_signame,no_pubkey,no_sigdump,no_aux')"
	ISSUER="$(grep 'Issuer:' <<< "${CERT_INFO}" | cut -d ' ' -f9-20)"
	VALID_UNTIL="$(grep 'Not After :' <<< "${CERT_INFO}" | xargs)"
	SUBJECT="$(grep 'Subject:' <<< "${CERT_INFO}" | xargs)"
	SAN="$(grep 'DNS:' <<< "${CERT_INFO}" | xargs)"

	printf "%s\n%s\n%s\n%s\n" "${ISSUER}" "${VALID_UNTIL}" "${SUBJECT}" "${SAN}"
}

httpval() {
	local URL=${1}
	curl --raw -LsD - -o /dev/null "${URL}" |
		grep -v -E '(Connection:|Date:|Server:|X-Frame-Options:|Keep-Alive:|Content-Length:|Content-Type:|Via:|Retry-After:|Content-Language:|Vary:|Content-Encoding:|Transfer-Encoding:|Set-Cookie:)'
}

mp4_dl() {
	local YOUTUBE_URL="${1}"

	yt-dlp \
		-f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' \
		--merge-output-format mp4 "${YOUTUBE_URL}"
}

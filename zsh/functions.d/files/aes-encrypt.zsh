#!/bin/env bash

# Couleurs
BLUE='\033[0;34m'
BOLD="\033[1m"
GREEN='\033[0;32m'
MAGENTA="\033[0;35m"
NC="\033[0m"
RED='\033[0;31m'
RESET='\033[0m'
YELLOW='\033[0;33m'

print_color() {
	local color="$1"
	shift
	echo -e "${color}$*${RESET}"
}

read_password() {
	local input_key
	print_color "$BLUE" "Entrez le mot de passe :" >&2
	read -s input_key
	echo -n "$input_key"
}

get_key_from_file() {
	local key_file="$1"
	[[ -z $key_file ]] && key_file="$HOME/.clef"
	if [[ -f $key_file && -r $key_file ]]; then
		tr -d '\n' < "$key_file"
	else
		print_color "$RED" "Erreur : fichier de clé '$key_file' inaccessible." >&2
		return 1
	fi
}

encrypt_file() {
	local USE_PASSWORD=false USE_BASE64=false key_source fichier_a_chiffrer output_file password
	while getopts "pf:k:b" opt; do
		case $opt in
		p) USE_PASSWORD=true ;;
		f) fichier_a_chiffrer="$OPTARG" ;;
		k) key_source="$OPTARG" ;;
		b) USE_BASE64=true ;;
		\?)
			print_color "$RED" "Option invalide : -$OPTARG" >&2
			return 1
			;;
		esac
	done
	shift $((OPTIND - 1))

	[[ -z $fichier_a_chiffrer ]] && {
		print_color "$RED" "Erreur : Aucun fichier à chiffrer spécifié. Utilisation : encrypt_file -f <fichier> [-k <clé> | -p | -b]"
		return 1
	}
	[[ ! -f $fichier_a_chiffrer ]] && {
		print_color "$RED" "Erreur : '$fichier_a_chiffrer' introuvable."
		return 1
	}
	output_file="${1:-$fichier_a_chiffrer.enc}"

	if $USE_PASSWORD; then
		password=$(read_password)
	else
		[[ -n $key_source ]] && password=$(get_key_from_file "$key_source") || password=$(get_key_from_file)
	fi
	[[ -z $password ]] && {
		print_color "$RED" "Erreur : mot de passe ou clé vide."
		return 1
	}

	if $USE_BASE64; then
		sudo nice -n -15 openssl enc -e -aes-256-cbc -salt -pbkdf2 -iter 200000 \
			-pass pass:"$password" -in "$fichier_a_chiffrer" | base64 -w0 > "$output_file"
	else
		sudo nice -n -15 openssl enc -e -aes-256-cbc -salt -pbkdf2 -iter 200000 \
			-pass pass:"$password" -in "$fichier_a_chiffrer" -out "$output_file"
	fi

	if [[ $? -eq 0 ]]; then
		print_color "$GREEN" "Fichier chiffré avec succès → '$output_file'"
	else
		print_color "$RED" "Erreur lors du chiffrement."
		return 1
	fi
}

decrypt_file() {
	local USE_PASSWORD=false USE_BASE64=false key_source fichier_a_dechiffrer output_file password
	while getopts "pf:k:b" opt; do
		case $opt in
		p) USE_PASSWORD=true ;;
		f) fichier_a_dechiffrer="$OPTARG" ;;
		k) key_source="$OPTARG" ;;
		b) USE_BASE64=true ;;
		\?)
			print_color "$RED" "Option invalide : -$OPTARG" >&2
			return 1
			;;
		esac
	done
	shift $((OPTIND - 1))

	[[ -z $fichier_a_dechiffrer ]] && {
		print_color "$RED" "Aucun fichier à déchiffrer spécifié. Utilisation : decrypt_file -f <fichier> [-k <clé> | -p | -b]"
		return 1
	}
	[[ ! -f $fichier_a_dechiffrer ]] && {
		print_color "$RED" "Erreur : '$fichier_a_dechiffrer' introuvable."
		return 1
	}
	output_file="${1:-${fichier_a_dechiffrer%.enc}}"

	if [[ -e $output_file ]]; then
		print_color "$YELLOW" "Attention : '$output_file' existe déjà. Remplacer ? (o/n)"
		read -r choix
		[[ $choix != [oO] ]] && {
			print_color "$BLUE" "Annulé."
			return 1
		}
	fi

	if $USE_PASSWORD; then
		password=$(read_password)
	else
		[[ -n $key_source ]] && password=$(get_key_from_file "$key_source") || password=$(get_key_from_file)
	fi
	[[ -z $password ]] && {
		print_color "$RED" "Erreur : mot de passe ou clé vide."
		return 1
	}

	if $USE_BASE64; then
		base64 -d "$fichier_a_dechiffrer" |
			sudo nice -n -15 openssl enc -d -aes-256-cbc -salt -pbkdf2 -iter 200000 \
				-pass pass:"$password" -out "$output_file"
	else
		sudo nice -n -15 openssl enc -d -aes-256-cbc -salt -pbkdf2 -iter 200000 \
			-pass pass:"$password" -in "$fichier_a_dechiffrer" -out "$output_file"
	fi

	if [[ $? -eq 0 ]]; then
		print_color "$GREEN" "Fichier déchiffré avec succès → '$output_file'"
	else
		print_color "$RED" "Erreur lors du déchiffrement."
		rm -f "$output_file"
		return 1
	fi
}

alias dec-file=decrypt_file
alias decfile=decrypt_file
alias decf=decrypt_file

alias enc-file=encrypt_file
alias encfile=encrypt_file
alias encf=encrypt_file

# LC_ALL=C head -c 42 /dev/urandom | base64 | tee $PWD/key.key
# LC_ALL=C dd if=/dev/urandom bs=1024 count=1 | base64 --wrap=0 | tee >| $PWD/key.key
# dd if=/dev/urandom bs=1G count=1 | tee >| binfile

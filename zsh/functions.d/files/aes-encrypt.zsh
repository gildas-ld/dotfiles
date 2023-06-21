#!/bin/env bash

function chiffrer_fichier {
	if [ $# -lt 1 ]; then
		echo "Utilisation: chiffrer_fichier <fichier_a_chiffrer> [fichier_de_sortie] [clef]"
		return 1
	fi

	local fichier_a_chiffrer="$1"
	local fichier_sortie="${2:-$fichier_a_chiffrer.enc}"
	# Utilise ~/.clef comme clef par défaut si aucune clef n'est fournie
	local clef="${3:-$HOME/.clef}"

	if [ ! -f "$fichier_a_chiffrer" ]; then
		echo "Erreur : Le fichier à chiffrer '$fichier_a_chiffrer' n'existe pas."
		return 1
	fi

	if [ ! -f "$clef" ]; then
		echo "Erreur : Le fichier de clef '$clef' n'existe pas."
		return 1
	fi

	# Chiffre le fichier
	openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 -pass file:"$clef" -in "$fichier_a_chiffrer" -out "$fichier_sortie"

	# Vérifie si la commande s'est bien exécutée
	if [ $? -eq 0 ]; then
		echo "Le fichier a été chiffré avec succès et enregistré dans '$fichier_sortie'."
	else
		echo "Erreur lors du chiffrement du fichier."
		return 1
	fi
}
alias enc-file=chiffrer_fichier

function dechiffrer_fichier {
	if [ $# -lt 1 ]; then
		echo "Utilisation: dechiffrer_fichier <fichier_a_déchiffrer> [fichier_de_sortie] [clef]"
		return 1
	fi

	local fichier_a_dechiffrer="$1"
	local fichier_sortie="${2:-${fichier_a_dechiffrer%.enc}}"
	local clef="${3:-$HOME/.clef}"

	if [ ! -f "$fichier_a_dechiffrer" ]; then
		echo "Erreur : Le fichier à déchiffrer '$fichier_a_dechiffrer' n'existe pas."
		return 1
	fi

	if [ ! -f "$clef" ]; then
		echo "Erreur : Le fichier de clef '$clef' n'existe pas."
		return 1
	fi

	# Exécute la commande OpenSSL pour déchiffrer le fichier
	openssl enc -d -aes-256-cbc -salt -pbkdf2 -iter 100000 -pass file:"$clef" -in "$fichier_a_dechiffrer" -out "$fichier_sortie"

	# Vérifie si la commande s'est bien exécutée
	if [ $? -eq 0 ]; then
		echo "Le fichier a été déchiffré avec succès et enregistré dans '$fichier_sortie'."
	else
		# Supprime le fichier de sortie en cas d'échec du déchiffrement
		rm --interactive=always -v  "$fichier_sortie"
		echo "Erreur lors du déchiffrement du fichier."
		return 1
	fi

}
alias dec-file=dechiffrer_fichier

# LC_ALL=C head -c 42 /dev/urandom | base64 | tee $PWD/key.key

#!/usr/bin/zsh

function restrict-filenames() {

	folder="${1:-.}"

	find "$folder" -type f ! -path '*/.git/*' | while IFS= read -r filepath; do
		filename=$(basename -- "$filepath")
		directory=$(dirname -- "$filepath")

		newfilename=$(echo "$filename" | LANG=C.UTF-8 sed 's/ /_/g')

		# Vérification si le nom du fichier a changé
		if [[ $filename != "$newfilename" ]]; then
			echo "De : $filepath"
			echo "À : $directory/$newfilename"
			# Renommer le fichier
			mv -n "$filepath" "$directory/$newfilename"
			echo "Fichier renommé."
			echo "--------------------------------------------"
		fi
	done

}
alias normalize=restrict-filenames

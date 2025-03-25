#!/bin/bash

for file in *.pdf; do
	if [ $(stat -c%s "$file") -le $((6 * 1024 * 1024)) ]; then
		gs -dNOPAUSE -dBATCH -sDEVICE=jpeg -r150 -sOutputFile="${file%.pdf}-%03d.jpg" "$file"
	else
		echo "Ignoré : $file (taille supérieure à 6 Mo)"
	fi
done
# for file in *.pdf; do
#   if [ $(stat -c%s "$file") -le $((6 * 1024 * 1024)) ]; then
#     pdftoppm -jpeg "$file" "${file%.pdf}"
#   else
#     echo "Ignoré : $file (taille supérieure à 6 Mo)"
#   fi
# done
# for file in *.pdf; do
#   if [ $(stat -c%s "$file") -le $((6 * 1024 * 1024)) ]; then
#     magick "$file" "${file%.pdf}.jpg"
#   else
#     echo "Ignoré : $file (taille supérieure à 6 Mo)"
#   fi
# done

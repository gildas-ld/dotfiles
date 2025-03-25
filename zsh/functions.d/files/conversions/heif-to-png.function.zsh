#!/bin/zsh
#
convert-heif-to-png () {
  find . -iname "*.heic" -exec sh -c 'heif-convert -q 90 "$0" "${0%.*}.png"' {} \;
}


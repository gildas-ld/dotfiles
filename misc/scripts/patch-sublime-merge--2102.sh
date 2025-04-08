#!/bin/bash
cd "/Applications/Sublime Merge.app/Contents/MacOS/" || exit
md5 -q sublime_merge | grep -i "980AE5632EA58F7E4ECD55B7CE16D6BB" || exit

echo 000AFFCA: 48 C7 C0 00 00 00 00 C3 | xxd -r - sublime_merge
echo 000B24C6: 90 90 90 90 90 | xxd -r - sublime_merge
echo 000B24E5: 90 90 90 90 90 | xxd -r - sublime_merge
echo 000B0D8B: C3 | xxd -r - sublime_merge
echo 000AFCE6: C3 | xxd -r - sublime_merge

echo 013D30C4: 00 00 80 D2 C0 03 5F D6 | xxd -r - sublime_merge
echo 013D4DB4: 1F 20 03 D5 | xxd -r - sublime_merge
echo 013D4DC8: 1F 20 03 D5 | xxd -r - sublime_merge
echo 013D3C60: C0 03 5F D6 | xxd -r - sublime_merge
echo 013D2E4C: C0 03 5F D6 | xxd -r - sublime_merge

codesign --force --deep --sign - "/Applications/Sublime Merge.app"

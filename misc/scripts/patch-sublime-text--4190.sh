#!/bin/bash
cd "/Applications/Sublime Text.app/Contents/MacOS/" || exit
md5 -q sublime_text | grep -i "05C8DC38BEBAD7C9184EEAAC9D8286E9" || exit

echo 0009F824: 48 C7 C0 00 00 00 00 C3 | xxd -r - sublime_text
echo 00092A9C: 90 90 90 90 90 | xxd -r - sublime_text
echo 00092AB4: 90 90 90 90 90 | xxd -r - sublime_text
echo 000A0DF7: C3 | xxd -r - sublime_text
echo 0009F4DA: C3 | xxd -r - sublime_text

echo 00FCA61C: 00 00 80 D2 C0 03 5F D6 | xxd -r - sublime_text
echo 00FC08BC: 1F 20 03 D5 | xxd -r - sublime_text
echo 00FC08D0: 1F 20 03 D5 | xxd -r - sublime_text
echo 00FCB974: C0 03 5F D6 | xxd -r - sublime_text
echo 00FCA31C: C0 03 5F D6 | xxd -r - sublime_text

codesign --force --deep --sign - "/Applications/Sublime Text.app"

#!/usr/bin/zsh

alias ss="ss -tulpna"
alias sm='(nohup /usr/bin/smerge "${1:-.}" >/dev/null 2>&1 )' # & disown)'
alias st='(nohup /usr/bin/sublime_text "${1:-.}" >/dev/null 2>&1 )' # & disown)'
alias myip="hostname -i | awk '{ print $1 }'"
if [[ "$SHOULD_POWER_OFF" == "1" ]]; then
    alias mù='systemctl poweroff -i'
fi
alias mùù='systemctl reboot -i'

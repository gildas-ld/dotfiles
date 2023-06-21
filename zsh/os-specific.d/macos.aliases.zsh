#!/usr/bin/zsh

alias i="brew install"
alias l="ls -lAh -F -G --color=auto "
alias lm="ls -lAh -F -G --color=auto "
alias ls="ls -lAhltr -F -G --color=auto "
alias lsf='ls -lArth -F -G --color=auto '
alias maj="brew outdated -v ; brew update && brew upgrade && brew upgrade --cask --greedy ; brew cleanup --prune=60 "
alias mù="shutdown -h now"
alias mùù="shutdown -r now"
alias open='open "${1:-.}"'
alias pc="pwd -P | pbcopy"
alias rsync-move='rsync -av --info=progress2 --remove-source-files'
alias rsync-synchronize='rsync -avzu --info=progress2 --delete'
alias rsync-update='rsync -avu --info=progress2'
alias si="brew search"
alias sm='nohup /Applications/Sublime\ Merge.app/Contents/MacOS/sublime_merge "${1:-.}" >/dev/null 2>&1 &'
alias smerge="nohup /Applications/Sublime\ Merge.app/Contents/MacOS/sublime_merge >/dev/null 2>&1 &"
alias smerge='nohup /Applications/Sublime\ Merge.app/Contents/MacOS/sublime_merge "${1:-.}" >/dev/null 2>&1 &'
alias ss="lsof -iTCP -sTCP:LISTEN -P ; netstat -an | grep -E 'Proto|LISTEN'"
alias st='nohup /Applications/Sublime\ Text.app/Contents/MacOS/sublime_text "${1:-.}" >/dev/null 2>&1 &'

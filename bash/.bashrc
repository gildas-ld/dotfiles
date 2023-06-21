[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


source /home/gildas/.local/bin
export EDITOR="vim"

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


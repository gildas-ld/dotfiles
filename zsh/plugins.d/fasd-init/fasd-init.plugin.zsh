alias a='fasd -a'        # any
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias fs='fasd -si'      # Show the most relevant files/directories with interactive menu
alias j='zz'             # Jump to a recently used directory with autojump (via zz)
alias o='a -e xdg-open'  # Open a file or directory with the default application
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias v='f -e "$EDITOR"' # Open a frequently used file in the default editor
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias fz='fasd -Rl | fzf'

# function to execute built-in cd
fasd_cd() {
  if [ $# -le 1 ]; then
    fasd "$@"
  else
    local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    [ -z "$_fasd_ret" ] && return 1
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf '%s\n' "$_fasd_ret"
  fi
}
alias z='fasd_cd -d'
alias zz='fasd_cd -d -i'

# add zsh hook
_fasd_preexec() {
  { fasd --proc $(fasd --sanitize "$2") } >> "/dev/null" 2>&1
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _fasd_preexec

# zsh command mode completion
_fasd_zsh_cmd_complete() {
  local compl
  read -c compl
  (( $+compstate )) && compstate[insert]=menu # no expand if compsys loaded
  reply=(${(f)"$(fasd --complete "$compl")"})
}

# enable command mode completion
compctl -U -K _fasd_zsh_cmd_complete -V fasd -x 'C[-1,-*e],s[-]n[1,e]' -c - \
  'c[-1,-A][-1,-D]' -f -- fasd fasd_cd

(( $+functions[compdef] )) && {
  # zsh word mode completion
  _fasd_zsh_word_complete() {
    [ "$2" ] && local _fasd_cur="$2"
    [ -z "$_fasd_cur" ] && local _fasd_cur="${words[CURRENT]}"
    local fnd="${_fasd_cur//,/ }"
    local typ=${1:-e}
    fasd --query $typ "$fnd" 2>> "/dev/null" | \
      sort -nr | sed 's/^[^ ]*[ ]*//' | while read -r line; do
        compadd -U -V fasd "$line"
      done
    compstate[insert]=menu # no expand
  }
  _fasd_zsh_word_complete_f() { _fasd_zsh_word_complete f ; }
  _fasd_zsh_word_complete_d() { _fasd_zsh_word_complete d ; }
  _fasd_zsh_word_complete_trigger() {
    local _fasd_cur="${words[CURRENT]}"
    eval $(fasd --word-complete-trigger _fasd_zsh_word_complete $_fasd_cur)
  }
  # define zle widgets
  zle -C fasd-complete complete-word _generic
  zstyle ':completion:fasd-complete:*' completer _fasd_zsh_word_complete
  zstyle ':completion:fasd-complete:*' menu-select

  zle -C fasd-complete-f complete-word _generic
  zstyle ':completion:fasd-complete-f:*' completer _fasd_zsh_word_complete_f
  zstyle ':completion:fasd-complete-f:*' menu-select

  zle -C fasd-complete-d complete-word _generic
  zstyle ':completion:fasd-complete-d:*' completer _fasd_zsh_word_complete_d
  zstyle ':completion:fasd-complete-d:*' menu-select
}

(( $+functions[compdef] )) && {
  # enable word mode completion
  orig_comp="$(zstyle -L ':completion:\*' completer 2>> "/dev/null")"
  if [ "$orig_comp" ]; then
    case $orig_comp in
      *_fasd_zsh_word_complete_trigger*);;
      *) eval "$orig_comp _fasd_zsh_word_complete_trigger";;
    esac
  else
    zstyle ':completion:*' completer _complete _fasd_zsh_word_complete_trigger
  fi
  unset orig_comp
}


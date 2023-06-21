############
## Gildas ##
############

set -o noclobber # Prevent overwriting the contents of a file when redirecting output

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

source ~/zsh/.zshtheme
source ~/zsh/.zstyles
source ~/zsh/.zshopts

zmodload zsh/zprof

plugins=(
    # aws
    # brew
    # composer
    # docker
    # docker-compose
    # fancy-ctrl-z
    # history
    # macos
    aliases
    aws
    brew
    colored-man-pages
    colorize
    composer
    fancy-ctrl-z
    fzf
    git
    git-flow-avh
    gnu-utils
    history
    laravel
    macos
    man
    nmap
    sublime-merge
    sudo
    symfony
    systemd
    timer
    tmux
    zsh-completions
    zsh-interactive-cd
    zsh-z
)

source ~/zsh/.zstyles

# Aliases
for f in ~/zsh/aliases.d/**/*; do
    . $f
done

# Functions
for f in ~/zsh/functions.d/**/*; do
    . $f
done

for c in cp rm chmod chown rename; do
    alias $c="$c -v"
done

if [[ "$(uname)" == "Darwin" ]]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $HOME/dotfiles/zsh/plugins.d/zsh-z/zsh-z.plugin.zsh
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

else
    # Search path for sudo completion
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
        /usr/local/bin  \
        /usr/sbin       \
        /usr/bin        \
        /sbin           \
        /bin            \
        /usr/X11R6/bin

    fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
    zstyle ':omz:plugins:nvm' lazy yes
    # source ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-z/zsh-z.plugin.zsh
    source $HOME/dotfiles/zsh/plugins.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $HOME/dotfiles/zsh/plugins.d/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $HOME/dotfiles/zsh/plugins.d/zsh-z/zsh-z.plugin.zsh
fi

# debug (find alias ls=)
# zsh -ixc : 2>&1 | grepls=
# theme : jtriley
# export PATH="/usr/local/opt/postg resql@15/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/postgresql@15/lib"
# export CPPFLAGS="-I/usr/local/opt/postgresql@15/include"
export PATH="$PATH:$HOME/.local/bin"

alias python="python3"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export PATH="${HOME}/.config/composer/vendor/bin/phpcbf:$PATH"
export PATH="/usr/local/opt/node@18/bin:$PATH"
export PATH="/usr/local/opt/postgresql@16/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
export PATH="/usr/local/go/bin/:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Load Angular CLI autocompletion.
# source <(ng completion script)
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init --path)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

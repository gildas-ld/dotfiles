############
## Gildas ##
############

set -o noclobber

zmodload zsh/zprof

autoload -Uz compinit
compinit -C

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Includes
source ~/zsh/.zshenv
source ~/zsh/.zshopts
source ~/zsh/.zshtheme
source ~/zsh/.zstyles

# bind UP and DOWN arrow keys for history substring search
zmodload zsh/terminfo

if [[ $USER != *ledro_gi* ]]; then
	bindkey "$terminfo[kcuu1]" history-substring-search-up
	bindkey "$terminfo[kcud1]" history-substring-search-down
fi

# Plugins
plugins=(
	aliases
	colored-man-pages
	colorize
	fzf
	git
	git-flow-avh
	gnu-utils
	history
	man
	nmap
	sublime-merge
	sudo
	systemd
	timer
	tmux
	zsh-autopair
	zsh-completions
	zsh-history-substring-search
	zsh-interactive-cd
)

for f in ~/zsh/{aliases.d,functions.d}/**/*; do
	source $f
done

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
	/usr/local/bin \
	/usr/sbin \
	/usr/bin \
	/sbin \
	/bin \
	/usr/X11R6/bin

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
for plugin in fasd-init zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search zsh-autopair; do
	source $HOME/dotfiles/zsh/plugins.d/$plugin/$plugin.plugin.zsh
done

export PATH="$PATH:$HOME/.local/bin"

# export LD_LIBRARY_PATH=/usr/local/lib
export PATH="/usr/local/go/bin/:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/postgresql@16/bin:$PATH"
export PATH="${HOME}/.config/composer/vendor/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

if [[ ! -s ~/.zshrc.zwc || ~/.zshrc -nt ~/.zshrc.zwc ]]; then
  zcompile ~/.zshrc
fi

# debug (find alias ls=)
# zsh -ixc : 2>&1 | grepls=
#
fastfetch -c ~/.config/fastfetch/config-v3.jsonc

sysstats

# zprof

# . "$HOME/.local/share/../bin/env"
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYTHON=$(which python3)
fpath=(~/.git-completion.zsh $fpath)

export PATH="$HOME/.cargo/bin:$PATH"

export QSYS_ROOTDIR="/home/gildas/altera/24.1std/quartus/sopc_builder/bin"

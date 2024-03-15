# export DOCKER_USER="$(id -u):$(id -g)"
# export DOCKER_USER="1000:1000"
# export GID=1000
# export UID=1000
# export XDG_RUNTIME_DIR=/run/user/$(id -u)


if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    # export ANKI_WAYLAND=1
    # export QT_QPA_PLATFORM=wayland
    export BEMENU_BACKEND=wayland
    export CLUTTER_BACKEND=wayland
    export MOZ_DISABLE_RDD_SANDBOX=1
    export MOZ_ENABLE_WAYLAND=1
    export MOZ_WAYLAND_USE_VAAPI=1
fi

if [[ "$(uname)" != "Darwin" ]]; then
    export GREP_OPTIONS='--color=auto --ignore-case --extended-regexp --recursive'
    # export HOME="${HOME:-$(eval echo ~$USER)}"
    export HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
    export LESS='--line-numbers --long-prompt --status-column --squeeze-blank-lines --file-size --save-marks --ignore-case --hilite-unread'
    export QT_STYLE_OVERRIDE=adwaita-dark
    export SDL_VIDEODRIVER="wayland,x11"
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
    export USER=${USER:-$(id -u -n)}
    export XDG_CACHE_HOME="${HOME}/.cache"
    export XDG_CONFIG_HOME="${HOME}/.config"
    export XDG_CURRENT_DESKTOP=gnome
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_RUNTIME_DIR=/run/user/1000
    export XDG_STATE_HOME="${HOME}/.local/state"
    export _JAVA_AWT_WM_NONREPARENTING=1

else
    export GREP_OPTIONS='--color=auto --extended-regexp'
    export HOMEBREW_CASK_OPTS=--require-sha
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_NO_ANALYTICS=1
fi

export BAT_THEME="ansi"
export BEMENU_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export COMPLETION_WAITING_DOTS="true"
export COMPOSE_DOCKER_CLI_BUILD=1
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export DATE_="$(date +"%Y_%m_%d__%H%M_%S")"
export DOCKER_BUILDKIT=1
export DOCKER_USER="$(id -u):$(id -g)"
export EDITOR=vim
export ENABLE_CORRECTION="true"
export ENV=$HOME/.zshrc
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --extended'
export GID=$(id -g)
export GPG_TTY=$(tty)
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=1000000
export HISTSIZE=10000000
export HIST_STAMPS="%-d.%-m.%Y %H:%M:%S"
export HYPHEN_INSENSITIVE="true"
export LANG="fr_FR.UTF-8"
export LANGUAGE="fr:en"
export LC_ADDRESS="fr_FR.UTF-8"
export LC_ALL=
export LC_COLLATE="fr_FR.UTF-8"
export LC_CTYPE="fr_FR.UTF-8"
export LC_IDENTIFICATION="fr_FR.UTF-8"
export LC_MEASUREMENT="fr_FR.UTF-8"
export LC_MESSAGES="fr:en"
export LC_MESSAGES="fr_FR.UTF-8"
export LC_MONETARY="fr_FR.UTF-8"
export LC_NAME="fr_FR.UTF-8"
export LC_NUMERIC="fr_FR.UTF-8"
export LC_PAPER="fr_FR.UTF-8"
export LC_TELEPHONE="fr_FR.UTF-8"
export LC_TIME="fr_FR.UTF-8"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export LESS_TERMCAP_mb=$(printf '\33[01;35m')
export LESS_TERMCAP_md=$(printf '\33[01;35m')
export LESS_TERMCAP_me=$(printf '\33[0m')
export LESS_TERMCAP_se=$(printf '\33[0m')
export LESS_TERMCAP_so=$(printf '\33[01;44;33m')
export LESS_TERMCAP_ue=$(printf '\33[0m')
export LESS_TERMCAP_us=$(printf '\33[01;32m')
export PAGER='less -R'
export QT_STYLE_OVERRIDE=adwaita-dark
export SDL_VIDEODRIVER="wayland,x11"
export SHELL_SESSIONS_DISABLE=1
export TERM='xterm-256color'
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
export TZ='Europe/Paris'
export UID=$(id -u)
export VISUAL=vim
export ZSH="$HOME/.oh-my-zsh"
export ZSHZ_CASE=smart
export ZSHZ_ECHO=1
export ZSH_DISABLE_COMPFIX=true
# Report any login/logout of other users
# export WATCH=notme
export WATCH=all
export WATCHFMT='%n %a %l from %m at %T.'
export REPORTTIME=15

# export ZSH_THEME="mikeh"

if test -f "$HOME/.zshdebug"; then
    source $HOME/.zshdebug
fi

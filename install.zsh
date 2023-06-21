#!/usr/bin/env zsh

setopt ERR_EXIT

alias -g ln="ln -sfv"

GIT_TOP_LEVEL=$(git rev-parse --show-toplevel)
DOTFILES=$GIT_TOP_LEVEL

# Colors :
NC="\033[0m"
RED="\033[0;31m"

# Stderr and exit with an error
die() {
	clear
	echo -e "${RED}$* ${NC}\n" >&2
	exit 2
}

if [[ $EUID == 0 ]]; then
	die "Do not run this script with sudo !"
elif [ "$PWD" != "$GIT_TOP_LEVEL" ]; then
	die "You must be at the location of the script in order to execute it..."
fi

printf "Do you want to install dotfiles ? (y/N)\n"
while true; do
	read -r choice
	case $choice in
	[Yy])
		install=1
		break
		;;
	[Nn])
		install=0
		break
		;;
	*)
		printf "${RED}Please answer y or n.${NC}\n"
		;;

	esac
done
if [ "$install" = "1" ]; then
	clear
	printf "${RED}Dotfiles is being installed...${NC}\n\n"

	rm -rf $HOME/vim
	rm -rf $HOME/.config/nvim

	ln $DOTFILES/vim $HOME
	ln $DOTFILES/vim/.vimrc $HOME

	mkdir -pv $HOME/.config/nvim
	ln $DOTFILES/vim/.vimrc $HOME/.config/nvim/init.vim
	printf "\n"

	rm -rf $HOME/zsh
	ln $DOTFILES/zsh $HOME
	ln $DOTFILES/zsh/.zshrc $HOME
	ln $DOTFILES/zsh/.zshenv $HOME
	ln $DOTFILES/zsh/.zstyles $HOME
	ln $DOTFILES/zsh/.zshopts $HOME
	ln $DOTFILES/zsh/.zshtheme $HOME
	printf "\n"

	rm -rf $HOME/.tmux
	ln $DOTFILES/.config/.tmux $HOME
	ln $DOTFILES/.config/.tmux/.tmux.conf $HOME
	ln $DOTFILES/.config/.tmux/.tmux.conf.local $HOME
	printf "\n"

	rm -rf $HOME/.config/alacritty
	ln $DOTFILES/.config/alacritty $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/sway
	ln $DOTFILES/.config/sway $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/htop
	ln $DOTFILES/.config/htop $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/wofi
	ln $DOTFILES/.config/wofi $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/yt-dlp
	ln $DOTFILES/.config/yt-dlp $HOME/.config
	printf "\n"

	rm -rf $HOME/.config/gammastep
	ln $DOTFILES/.config/gammastep $HOME/.config

	rm -rf $HOME/.config/waybar
	ln $DOTFILES/.config/waybar $HOME/.config
else
	printf "${RED}We won't install the dotfiles.${NC}\n"
	exit 0
fi

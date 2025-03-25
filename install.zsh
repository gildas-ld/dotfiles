#!/usr/bin/env zsh

setopt ERR_EXIT

# Colors
NC="\033[0m"
RED="\033[0;31m"

# Get root of the git repository
GIT_TOP_LEVEL=$(git rev-parse --show-toplevel)
DOTFILES=$GIT_TOP_LEVEL

# Exit with error message
die() {
	clear
	echo -e "${RED}$* ${NC}\n" >&2
	exit 2
}

# Do not run as root
if [[ $EUID == 0 ]]; then
	die "Do not run this script with sudo!"
elif [[ $PWD != "$GIT_TOP_LEVEL" ]]; then
	die "You must run this script from the project root directory"
fi

# Handle --yes option
bypass=false
while [[ $# -gt 0 ]]; do
	case $1 in
	-y | --yes)
		bypass=true
		shift
		;;
	*)
		die "Unknown option: $1"
		;;
	esac
done

# Ask user for confirmation if --yes is not set
if [[ $bypass == true ]]; then
	install=1
else
	printf "Do you want to install the dotfiles? (y/N)\n"
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
		*) printf "${RED}Please answer y or n.${NC}\n" ;;
		esac
	done
fi

if [[ $install != "1" ]]; then
	printf "${RED}We won't install the dotfiles.${NC}\n"
	exit 0
fi

clear
printf "${RED}Installing dotfiles...${NC}\n\n"

# Install oh-my-zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Installing oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Helper: remove path safely
safe_rm() {
	rm -rf "$1"
}

# Helper: create link (replace existing)
link() {
	safe_rm "$2"
	ln -sfv "$1" "$2"
}

# Helper: update git submodules
update_submodules() {
	git submodule update --init --checkout --force --recursive --remote --verbose
	git submodule sync --recursive
	git submodule foreach '
		echo "Updating submodule in $(pwd)"
		git stash push --include-untracked -m "Auto stash before rebase"
		BRANCH=$(git symbolic-ref --short -q HEAD)
		if [ -z "$BRANCH" ]; then
			if git show-ref --verify --quiet refs/heads/main; then
				echo "Switching to main branch"
				git checkout main
				BRANCH="main"
			elif git show-ref --verify --quiet refs/heads/master; then
				echo "Switching to master branch"
				git checkout master
				BRANCH="master"
			else
				echo "No 'main' or 'master' branch found"
				exit 1
			fi
		fi
		git pull origin "$BRANCH" --rebase=interactive --autostash
		if git stash list | grep -q "Auto stash before rebase"; then
			git stash pop
		fi
	'
}

# Helper: link config directories
link_config_dirs() {
	for cfg in alacritty sway swaync htop aria2 wofi yt-dlp gammastep waybar; do
		link "$DOTFILES/.config/$cfg" "$HOME/.config/$cfg"
	done
}

# Helper: link VS Codium configs
link_vscodium() {
	local user_dir="$HOME/.config/VSCodium/User"
	mkdir -pv "$user_dir"
	rm -f "$user_dir"/{settings,keybindings}.json
	rm -rf "$user_dir/snippets"
	link "$DOTFILES/vscode/snippets" "$user_dir"
	link "$DOTFILES/vscode/settings.json" "$user_dir/settings.json"
	link "$DOTFILES/vscode/keybindings.json" "$user_dir/keybindings.json"
}

# Start installation steps

# Update git submodules
update_submodules
printf "\n"

# Vim
safe_rm "$HOME/vim"
safe_rm "$HOME/.config/nvim"
link "$DOTFILES/vim" "$HOME/vim"
link "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"
mkdir -pv "$HOME/.config/nvim"
link "$DOTFILES/vim/.vimrc" "$HOME/.config/nvim/init.vim"
printf "\n"

# Zsh
safe_rm "$HOME/zsh"
link "$DOTFILES/zsh" "$HOME/zsh"
for file in .zshrc .zshenv .zstyles .zshopts .zshtheme; do
	link "$DOTFILES/zsh/$file" "$HOME/$file"
done
printf "\n"

# Bash
safe_rm "$HOME/bash"
link "$DOTFILES/bash" "$HOME/bash"
link "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"
printf "\n"

# Tmux
safe_rm "$HOME/.tmux"
link "$DOTFILES/.config/.tmux" "$HOME/.tmux"
if [ -d "oh-my-tmux" ]; then
	cp -avf oh-my-tmux/.tmux.conf "$DOTFILES/.config/.tmux/.tmux.conf"
	link "$DOTFILES/.config/.tmux/.tmux.conf" "$HOME/.tmux.conf"
	link "$DOTFILES/.config/.tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
else
	die "The 'oh-my-tmux' directory is missing. Please check submodules."
fi
printf "\n"

# Various configs
link_config_dirs
printf "\n"

# VSCodium
link_vscodium
printf "\n"

# Sublime Text
sublime_user="$HOME/.config/sublime-text/Packages/User"
mkdir -pv "$sublime_user"
link "$DOTFILES/.config/sublime-text/Default (Linux).sublime-keymap" "$sublime_user/Default (Linux).sublime-keymap"
link "$DOTFILES/.config/sublime-text/Preferences.sublime-settings" "$sublime_user/Preferences.sublime-settings"
printf "\n"

# Claws-mail
safe_rm "$HOME/.config/claws-mails"
link "$DOTFILES/.config/claws-mails" "$HOME/.config/claws-mails"
link "$DOTFILES/.config/claws-mails/signature.sh" "$HOME/signature.sh"

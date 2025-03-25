#!/usr/bin/env zsh
setopt ERR_EXIT

GIT_TOP_LEVEL=$(git rev-parse --show-toplevel)
DOTFILES=$GIT_TOP_LEVEL

source "$DOTFILES/scripts/utils.zsh"
source "$DOTFILES/scripts/install.zsh"

# Prevents execution as root
if [[ $EUID == 0 ]]; then
	die "Do not run this script with sudo!"
elif [[ $PWD != "$GIT_TOP_LEVEL" ]]; then
	die "You must run this script from the project root directory"
fi

# Analyze the arguments
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

# Confirmation request
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

if [[ $install != 1 ]]; then
	printf "${RED}We won't install the dotfiles.${NC}\n"
	exit 0
fi

clear
printf "${RED}Installing dotfiles...${NC}\n\n"

# Execution
update_submodules
install_vim
install_zsh
install_bash
install_tmux
install_config_dirs
install_vscodium
install_session_links
install_sublime
install_claws_mail

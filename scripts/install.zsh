#!/usr/bin/env zsh

# Load utilities
source "$DOTFILES/scripts/utils.zsh"

install_vim() {
	safe_rm "$HOME/vim"
	link "$DOTFILES/vim" "$HOME/vim"
	link "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"
}

install_nvim() {
	safe_rm "$HOME/.config/nvim"
	link "$DOTFILES/.config/nvim" "$HOME/.config/nvim"
	
}

install_zsh() {
	safe_rm "$HOME/zsh"
	link "$DOTFILES/zsh" "$HOME/zsh"
	for file in .zshrc .zshenv .zstyles .zshopts .zshtheme; do
		link "$DOTFILES/zsh/$file" "$HOME/$file"
	done
}

install_bash() {
	safe_rm "$HOME/bash"
	link "$DOTFILES/bash" "$HOME/bash"
	link "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"
}

install_tmux() {
	safe_rm "$HOME/.tmux"
	link "$DOTFILES/.config/.tmux" "$HOME/.tmux"
	if [ -d "oh-my-tmux" ]; then
		cp -avf oh-my-tmux/.tmux.conf "$DOTFILES/.config/.tmux/.tmux.conf"
		link "$DOTFILES/.config/.tmux/.tmux.conf" "$HOME/.tmux.conf"
		link "$DOTFILES/.config/.tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
	else
		die "The 'oh-my-tmux' directory is missing. Please check submodules."
	fi
}

install_config_dirs() {
	for cfg in alacritty aria2 btop fastfetch fish gammastep htop kitty rofi swappy tilix waybar wofi yt-dlp; do
		# for cfg in ags alacritty aria2 btop cava fish gammastep htop kitty qt5ct qt6ct rofi swappy sway swayidle swaync wallust waybar wlogout wofi xfce4 yt-dlp Kvantum Thunar; do
		link "$DOTFILES/.config/$cfg" "$HOME/.config/$cfg"
	done
}

install_vscodium() {
	local user_dir="$HOME/.config/VSCodium/User"
	mkdir -pv "$user_dir"
	rm -f "$user_dir"/{settings,keybindings}.json
	rm -rf "$user_dir/snippets"
	link "$DOTFILES/vscode/snippets" "$user_dir"
	link "$DOTFILES/vscode/settings.json" "$user_dir/settings.json"
	link "$DOTFILES/vscode/keybindings.json" "$user_dir/keybindings.json"
}

install_session_links() {
	case "$DESKTOP_SESSION" in
	sway)
		# Create a link to the old config file specifically for waybar
		link "$DOTFILES/.config/waybar/configs/OLD_config" "$HOME/.config/waybar/config"
		# Create a link to the old style file for waybar
		# link "$DOTFILES/.config/waybar/style/OLD_style.css" "$HOME/.config/waybar/style.css"
		link "$DOTFILES/.config/waybar/style/Extra_Modern-Combined.css" "$HOME/.config/waybar/style.css"

		;;
	*)
		# Create a link to the default config for other sessions
		link "$DOTFILES/.config/waybar/configs/TOP_Default_Laptop" "$HOME/.config/waybar/config"
		# Create a link to the modern combined style for other sessions
		link "$DOTFILES/.config/waybar/style/Extra_Modern-Combined.css" "$HOME/.config/waybar/style.css"
		;;
	esac
}

install_sublime() {
	local sublime_user="$HOME/.config/sublime-text/Packages/User"
	mkdir -pv "$sublime_user"
	link "$DOTFILES/.config/sublime-text/Default (Linux).sublime-keymap" "$sublime_user/Default (Linux).sublime-keymap"
	link "$DOTFILES/.config/sublime-text/Preferences.sublime-settings" "$sublime_user/Preferences.sublime-settings"
}

install_claws_mail() {
	safe_rm "$HOME/.config/claws-mails"
	link "$DOTFILES/.config/claws-mails" "$HOME/.config/claws-mails"
	link "$DOTFILES/.config/claws-mails/signature.sh" "$HOME/signature.sh"
}

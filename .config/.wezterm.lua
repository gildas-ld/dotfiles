local wezterm = require("wezterm")

return {
	font = wezterm.font("FiraCode Nerd Font", { weight = "Regular", italic = false }),
	font_size = 15,
	colors = {
		background = "#141414",
		cursor_bg = "#DB193B",
		cursor_border = "#DB193B",
		cursor_fg = "#141414",
		foreground = "#EAEAEA",
		selection_bg = "#3B6EA8",
		selection_fg = "#EAEAEA",
	},
	-- hide_tab_bar_if_only_one_tab = false,
	-- window_decorations = "TITLE | RESIZE",
	audible_bell = "Disabled",
	default_prog = { "/bin/zsh", "-l" },
	enable_wayland = true,
	scrollback_lines = 15000,
	use_fancy_tab_bar = false,
	window_background_opacity = 1,
	window_decorations = "NONE",
	show_new_tab_button_in_tab_bar = true,
	show_tab_index_in_tab_bar = false,
	show_tabs_in_tab_bar = true,
	mouse_bindings = {
		{
			-- Select cell normally with left click
			event = { Down = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = wezterm.action.SelectTextAtMouseCursor("Cell"),
		},
		{
			-- Use SUPER + click for block selection
			event = { Down = { streak = 1, button = "Left" } },
			mods = "SUPER",
			action = wezterm.action.SelectTextAtMouseCursor("Block"),
		},
	},
	selection_word_boundary = " \t\n{}[]()\"'`,;:.",

	keys = {
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "Enter",
			mods = "CTRL|ALT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "e",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "o",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "t",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = wezterm.action.ActivateTabRelative(1),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivateTabRelative(-1),
		},
	},
}

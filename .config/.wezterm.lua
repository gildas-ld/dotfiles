local wezterm = require("wezterm")

return {

	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"FiraCode Nerd Font",
		"Iosevka Nerd Font",
		"Cascadia Code Nerd Font",
		"Hack Nerd Font",
	}),

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

	animation_fps = 120,
	audible_bell = "Disabled",
	cell_width = 1,
	default_prog = { "/bin/zsh", "-l" },
	enable_kitty_graphics = true,
	enable_wayland = true,
	freetype_load_target = "Normal",
	freetype_render_target = "HorizontalLcd",
	front_end = "WebGpu",
	harfbuzz_features = { "calt=0", "clig=0", "liga=1" },
	hide_tab_bar_if_only_one_tab = false,
	hyperlink_rules = wezterm.default_hyperlink_rules(),
	line_height = 1,
	scrollback_lines = 15000,
	show_new_tab_button_in_tab_bar = true,
	show_tab_index_in_tab_bar = false,
	show_tabs_in_tab_bar = true,
	use_fancy_tab_bar = false,
	window_background_opacity = 1,
	window_decorations = "TITLE | RESIZE",

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

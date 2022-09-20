local wezterm = require "wezterm"

return {
	-- tabbar
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = false,

	-- wezterm
	check_for_updates = false,
	show_update_window = false,

	-- window
	window_background_opacity = 1,
	window_padding = {
		left = 16,
		right = 16,
		top = 16,
		bottom = 16,
	},

	-- appearance
	font = wezterm.font "JetBrainsMono Nerd Font",
	font_size = 13,
	color_scheme = "nord",
	default_cursor_style = "SteadyBlock",
	colors = {
		tab_bar = {
			background = "#2e3440",
			active_tab = {
				fg_color = "#eceff4",
				bg_color = "#3b4252",
			},
			inactive_tab = {
				fg_color = "#4c566a",
				bg_color = "#2e3440",
			},
			inactive_tab_hover = {
				fg_color = "#4c566a",
				bg_color = "#2e3440",
			},
			new_tab = {
				fg_color = "#4c566a",
				bg_color = "#2e3440",
			},
			new_tab_hover = {
				fg_color = "#eceff4",
				bg_color = "#2e3440",
			},
			inactive_tab_edge = "#4c566a",
		},
	},
}

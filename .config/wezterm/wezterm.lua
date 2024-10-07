local wezterm = require "wezterm"

local config = {}

config.font = wezterm.font("JetBrains Mono")
config.font_size = 15
config.line_height = 1.25

config.hide_tab_bar_if_only_one_tab = true

config.color_scheme = "GruvboxDarkHard"
config.window_padding = {
  left = 16,
  right = 16,
  top = 16,
  bottom = 16,
}

return config

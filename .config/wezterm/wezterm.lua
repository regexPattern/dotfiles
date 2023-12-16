local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("JetBrains Mono")
config.font_size = 15.3

config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.window_padding = {
	left = 24,
	right = 24,
	top = 24,
	bottom = 24,
}

-- config.window_background_opacity = 0.90
-- config.macos_window_background_blur = 64

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Github Dark High Contrast"
	else
		return "Github Light High Contrast"
	end
end

wezterm.on("window-config-reloaded", function(window)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

return config

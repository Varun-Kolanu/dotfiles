local wezterm = require("wezterm")

return {
	enable_wayland = false,

	-- Keybindings
	keys = {
		{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },
		-- You can add more shortcuts here if needed
	},

	-- Font settings
	font = wezterm.font_with_fallback({
		"FantasqueSansM Nerd Font",
		"Noto Color Emoji",
		"Symbols Nerd Font Mono",
		"Noto Sans CJK JP",
		"Noto Sans",
	}),
	font_size = 12.0,

	-- Enable blur and transparency
	window_background_opacity = 0.8,

	-- Remove tab bar
	enable_tab_bar = false,

	-- Remove window title bar but allow resizing
	window_decorations = "RESIZE",
}

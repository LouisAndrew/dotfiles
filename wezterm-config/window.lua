return function(wezterm, config)
	config.show_new_tab_button_in_tab_bar = false

	config.inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.5,
	}

	config.window_decorations = "RESIZE"
	local PADDING = 12
	config.window_padding = {
		top = PADDING,
		left = PADDING,
		right = PADDING,
		bottom = 0,
	}

	config.window_frame = {
		font = wezterm.font("Office Code Pro", { weight = "Bold" }),
		inactive_titlebar_bg = "#353535",
		inactive_titlebar_fg = "#cccccc",
		active_titlebar_fg = "#ffffff",
		inactive_titlebar_border_bottom = "#2b2042",
		active_titlebar_border_bottom = "#2b2042",
		button_fg = "#cccccc",
		button_bg = "#2b2042",
		button_hover_fg = "#ffffff",
		button_hover_bg = "#3b3052",
	}

	config.status_update_interval = 1000
	config.enable_kitty_graphics = true
end

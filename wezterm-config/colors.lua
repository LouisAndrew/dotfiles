local preset_config = {
	light = {
		bg = "#131313",
		shade = "#0c0c0c",
	},
	dark = {
		bg = "#0a0a0a",
		shade = "#131313",
	},
}

local theme = "light"
local preset = preset_config[theme]

return function(_, config)
	config.colors = {
		ansi = {
			"#212121",
			"#ff8185",
			"#81ffbb",
			"#ffd6b3",
			"#93c5fd",
			"#818cf8",
			"#97CCF1",
			"#d5d5d5",
		},
		brights = {
			"#555555",
			"#ff8185",
			"#81ffbb",
			"#ffd6b3",
			"#93c5fd",
			"#818cf8",
			"#97CCF1",
			"#d5d5d5",
		},
		background = preset.bg,

		compose_cursor = "#eebebe",
		cursor_bg = "#ffcfa7",
		cursor_border = "#ffcfa7",
		cursor_fg = "#232634",
		foreground = "#b4b4b4",
		scrollbar_thumb = "#626880",
		selection_bg = "#626880",
		selection_fg = "#d5d5d5",
		split = preset.shade,
		visual_bell = "#414559",

		tab_bar = {
			background = preset.bg,

			active_tab = {
				bg_color = "#818cf8",
				fg_color = "#232634",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},

			inactive_tab = {
				bg_color = preset.bg,
				fg_color = "#9a9a9a",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},

			inactive_tab_hover = {
				bg_color = "#303446",
				fg_color = "#d5d5d5",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},

			new_tab = {
				bg_color = "#414559",
				fg_color = "#d5d5d5",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},

			new_tab_hover = {
				bg_color = "#414559",
				fg_color = "#d5d5d5",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},
		},
	}
end

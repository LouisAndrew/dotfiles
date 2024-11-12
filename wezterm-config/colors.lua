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
		background = "#0a0a0a",

		compose_cursor = "#eebebe",
		cursor_bg = "#ffcfa7",
		cursor_border = "#ffcfa7",
		cursor_fg = "#232634",
		foreground = "#d5d5d5",
		scrollbar_thumb = "#626880",
		selection_bg = "#626880",
		selection_fg = "#d5d5d5",
		split = "#737994",
		visual_bell = "#414559",

		tab_bar = {
			background = "#0a0a0a",

			active_tab = {
				bg_color = "#818cf8",
				fg_color = "#232634",
				intensity = "Normal",
				italic = false,
				strikethrough = false,
				underline = "None",
			},

			inactive_tab = {
				bg_color = "#0a0a0a",
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

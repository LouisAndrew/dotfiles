return function(wezterm, config)
	config.font = wezterm.font_with_fallback({
		{ family = "CommitMono", weight = "Regular", scale = 1 },
		{ family = "nonicons", weight = "Thin", scale = 1 },
	})

	config.use_cap_height_to_scale_fallback_fonts = true

	-- CommitMono specific
	local font_size_increment = 0.75
	local font_size_small = 14.8
	local font_sizes = {
		small = font_size_small,
		regular = font_size_small + font_size_increment,
		large = font_size_small + (font_size_increment * 2),
	}

	config.font_size = font_sizes.regular

	config.line_height = 1.5
end

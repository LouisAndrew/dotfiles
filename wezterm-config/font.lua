return function(wezterm, config)
	config.font = wezterm.font_with_fallback({
		{ family = "CommitMono", weight = "Regular", scale = 1 },
		{ family = "nonicons", scale = 0.87 },
	})

	config.use_cap_height_to_scale_fallback_fonts = true
	config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

	-- CommitMono specific
	local font_size_increment = 0.75
	local font_size_small = 14.8
	local font_sizes = {
		small = font_size_small,
		regular = font_size_small + font_size_increment,
		large = font_size_small + (font_size_increment * 2),
	}

	config.font_size = font_sizes.regular

	config.line_height = 1.35
	-- config.line_height = 1.25
end

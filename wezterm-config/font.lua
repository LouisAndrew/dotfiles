return function(wezterm, config)
	config.font = wezterm.font_with_fallback({
		{ family = "CommitMono", weight = "Regular", scale = 1 },
		{ family = "nonicons", scale = 0.87 },
	})

	config.use_cap_height_to_scale_fallback_fonts = true
	config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	config.font_size = 15
	config.line_height = 1.5
end

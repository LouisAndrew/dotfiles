return function(wezterm, config)
	local act = wezterm.action
	config.leader = { key = "i", mods = "CTRL", timeout_milliseconds = 1000 }
	config.keys = {
		{ key = "c", mods = "CTRL", action = act.SendKey({ key = "c", mods = "CTRL" }) },
		{ key = "v", mods = "CTRL", action = act.SendKey({ key = "v", mods = "CTRL" }) },
		{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
		{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },
		{
			key = "j",
			mods = "LEADER",
			action = act.SplitPane({ direction = "Down", size = { Percent = 40 } }),
		},
		{ key = "l", mods = "LEADER", action = act.SplitPane({ direction = "Right" }) },
		{
			key = "k",
			mods = "LEADER",
			action = act.SplitPane({ direction = "Up" }),
		},
		{ key = "h", mods = "LEADER", action = act.SplitPane({ direction = "Left" }) },
		{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
		{ key = "o", mods = "LEADER", action = act.EmitEvent("miniterm") },
		{
			key = "p",
			mods = "LEADER",
			action = act.EmitEvent("up-and-hide"),
		},
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
		},
		{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
		{
			key = "e",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Renaming Tab Title...:" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
		{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
		{
			key = "k",
			mods = "ALT|SHIFT",
			action = act.ScrollByLine(-1),
		},
		{
			key = "j",
			mods = "ALT|SHIFT",
			action = act.ScrollByLine(1),
		},
		{
			key = "u",
			mods = "ALT|SHIFT",
			action = act.ScrollByLine(-20),
		},
		{
			key = "d",
			mods = "ALT|SHIFT",
			action = act.ScrollByLine(20),
		},
	}

	for i = 1, 9 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = act.ActivateTab(i - 1),
		})
	end

	config.key_tables = {
		resize_pane = {
			{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
		move_tab = {
			{ key = "h", action = act.MoveTabRelative(-1) },
			{ key = "j", action = act.MoveTabRelative(-1) },
			{ key = "k", action = act.MoveTabRelative(1) },
			{ key = "l", action = act.MoveTabRelative(1) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
	}

	local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
	smart_splits.apply_to_config(config, {
		direction_keys = { "h", "j", "k", "l" },
		modifiers = {
			move = "CTRL",
			resize = "ALT",
		},
	})
end

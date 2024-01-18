local minimal_fedu = dofile("/Users/louis.andrew/.config/nvim/lua/colors.lua")

local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Tokyo Night"
local colors = {
	foreground = "silver",
	background = "#131313",
}

config.show_new_tab_button_in_tab_bar = false

config.colors = {
	background = colors.background,
	foreground = colors.foreground,
	tab_bar = {
		background = minimal_fedu.background,
		active_tab = {
			bg_color = minimal_fedu.background,
			fg_color = "#ffffff",
		},
		inactive_tab = {
			bg_color = minimal_fedu.background,
			fg_color = minimal_fedu.white_accent,
		},
	},
}

config.window_background_opacity = 1

config.font = wezterm.font_with_fallback({
	{ family = "Varys", weight = "Light" },
	{ family = "nonicons" },
	{ family = "codicon" },
})

config.use_cap_height_to_scale_fallback_fonts = true

config.font_size = 12
config.window_decorations = "RESIZE"
config.line_height = 1.45
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

local PADDING = 24
config.window_padding = {
	left = PADDING,
	right = PADDING,
	bottom = PADDING,
}

wezterm.on("up-and-hide", function(window, pane)
	window:perform_action(act.ActivatePaneDirection("Up"), pane)
	window:perform_action(act.TogglePaneZoomState, pane)
end)

-- @TODO create new pane if not exists, otherwise move down: https://wezfurlong.org/wezterm/config/lua/MuxTab/get_pane_direction.html?h=get+direction+pane
wezterm.on("miniterm", function(window, pane)
	local tab = window:active_tab()
	local bottom_pane = tab:get_pane_direction("Down")
	if bottom_pane == nil then
		window:perform_action(act.SplitPane({ direction = "Down", size = { Percent = 20 } }), pane)
	end

	window:perform_action(act.ActivatePaneDirection("Down"), pane)
end)

config.leader = { key = "i", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Send C-a when pressing C-a twice
	{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },

	-- create pane keybindings
	{
		key = "J",
		mods = "LEADER",
		action = act.SplitPane({ direction = "Down", size = { Percent = 40 } }),
	},
	{ key = "L", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- jump to panes
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "o", mods = "LEADER", action = act.EmitEvent("miniterm") },
	{
		key = "p",
		mods = "LEADER",
		action = act.EmitEvent("up-and-hide"),
	},

	-- But Wezterm offers custom "mode" in the name of "KeyTable"
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},

	-- Tab keybindings
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "n", mods = "LEADER", action = act.ShowTabNavigator },
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
	-- Key table for moving tabs around
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
	-- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
	{ key = "{", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },

	-- Lastly, workspace
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
}
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
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

-- Tab bar
-- I don't like the look of "fancy" tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false

wezterm.on("update-status", function(window)
	local stat = window:active_workspace()
	local stat_color = "#f7768e"

	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end

	if window:leader_is_active() then
		stat = "LDR"
		stat_color = "#bb9af7"
	end

	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = "  " .. stat },
		{ Text = " |" },
	}))
end)

config.window_frame = {
	font = wezterm.font("Office Code Pro", { weight = "Bold" }),
	inactive_titlebar_bg = "#353535",
	active_titlebar_bg = "#ff0000",
	inactive_titlebar_fg = "#cccccc",
	active_titlebar_fg = "#ffffff",
	inactive_titlebar_border_bottom = "#2b2042",
	active_titlebar_border_bottom = "#2b2042",
	button_fg = "#cccccc",
	button_bg = "#2b2042",
	button_hover_fg = "#ffffff",
	button_hover_bg = "#3b3052",
}

config.enable_kitty_graphics = true

return config

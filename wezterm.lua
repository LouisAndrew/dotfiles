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
			fg_color = minimal_fedu.misc.add_fg,
		},
		inactive_tab = {
			bg_color = minimal_fedu.background,
			fg_color = minimal_fedu.white_accent,
		},
	},
}

config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 0.5,
}

config.font = wezterm.font_with_fallback({
	{ family = "CommitMono", weight = "Regular", scale = 1 },
	{ family = "nonicons", weight = "Thin", scale = 1 },
})

config.use_cap_height_to_scale_fallback_fonts = true
config.font_size = 14.8
config.window_decorations = "RESIZE"
config.line_height = 1.4

local PADDING = 16
config.window_padding = {
	top = PADDING / 2,
	left = PADDING,
	right = PADDING,
	bottom = 2,
}

wezterm.on("up-and-hide", function(window, pane)
	window:perform_action(act.ActivatePaneDirection("Up"), pane)
	window:perform_action(act.TogglePaneZoomState, pane)
end)

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
	{ key = "c", mods = "CTRL", action = act.SendKey({ key = "c", mods = "CTRL" }) },
	{ key = "v", mods = "CTRL", action = act.SendKey({ key = "v", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },

	-- create pane keybindings
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

	-- jump to panes
	-- { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	-- { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	-- { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	-- { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
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

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

local custom_docnames = {
	["nvim"] = "config/nvim",
	["com~apple~CloudDocs"] = "iCloud",
	["iCloud~md~obsidian"] = "Obsidian",
}

local basename = function(s)
	if s == nil then
		return ""
	end

	local home = os.getenv("HOME")
	if s.path == home then
		return "~"
	end

	if s.path ~= nil then
		local home_resolved = string.gsub(s.path, home or "", "~")
		-- %1 is parent dir (scope), %2 is project name.
		local cwd = string.gsub(home_resolved, "^.*/(.*[/\\])(.*)$", "%2")
		return cwd
	end

	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab)
	local pane_info = ""
	local pane = tab.active_pane
	local cwd = basename(pane.current_working_dir) or basename(tab_title(tab))
	if custom_docnames[cwd] then
		cwd = custom_docnames[cwd]
	end

	local title = "[" .. tab.tab_index + 1 .. "] " .. cwd

	local mux_tab = wezterm.mux.get_tab(tab.tab_id)
	local pane_count = #mux_tab:panes()

	if pane_count > 1 then
		pane_info = " (" .. pane_count .. ")"
	end

	return " " .. title .. pane_info .. " "
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
config.tab_max_width = 48

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
		resize = "ALT",
	},
})

return config

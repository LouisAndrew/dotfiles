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

local function basename(s)
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

return function(wezterm, config)
	local custom_docnames = {
		["nvim"] = "config/nvim",
		["com~apple~CloudDocs"] = "iCloud",
		["iCloud~md~obsidian"] = "Obsidian",
	}

	wezterm.on("format-tab-title", function(tab)
		local pane_info = ""
		local pane = tab.active_pane
		local cwd = basename(pane.current_working_dir) or basename(tab_title(tab))
		if custom_docnames[cwd] then
			cwd = custom_docnames[cwd]
		elseif tab.tab_title ~= "" then
			cwd = tab.tab_title
		end

		local title = "[" .. tab.tab_index + 1 .. "] " .. cwd

		local mux_tab = wezterm.mux.get_tab(tab.tab_id)
		local pane_count = #mux_tab:panes()

		if pane_count > 1 then
			pane_info = " (" .. pane_count .. ")"
		end

		return " " .. title .. pane_info .. " "
	end)

	config.tab_max_width = 48
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
end

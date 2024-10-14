return function(wezterm, _)
	local act = wezterm.action
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
end

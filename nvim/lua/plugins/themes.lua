return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "projekt0n/github-nvim-theme", name = "github-theme" },
	{
		"kyza0d/xeno.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = true,
			contrast = 0.1,
		},
		config = function(_, opts)
			local xeno = require("xeno")

			xeno.config(opts)

			-- Create your custom theme
			xeno.new_theme("my-theme", {
				base = "#1E1E1E",
				accent = "#8CBE8C",
			})
		end,
	},
}

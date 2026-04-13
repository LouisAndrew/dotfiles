return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({})
		end,
	},
	{
		"kyza0d/xeno.nvim",
		lazy = false,
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
			vim.cmd("colorscheme my-theme")
		end,
	},
}

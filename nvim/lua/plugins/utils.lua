return {
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "/" },
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					names = false,
					RRGGBBAA = true,
					rgb_fn = true,
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		opts = {
			preview = {
				border = "single",
			},
			winblend = 0,
		},
	},
	{
		"johmsalas/text-case.nvim",
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
		keys = {
			"ga", -- Default invocation prefix
			{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
			{
				"gac",
				":lua require('textcase').current_word('to_camel_case')<CR>",
				mode = { "n", "x" },
			},
			{
				"gat",
				":lua require('textcase').current_word('to_title_case')<CR>",
				mode = { "n", "x" },
			},
		},
		cmd = {
			"TextCaseOpenTelescope",
			"TextCaseOpenTelescopeQuickChange",
			"TextCaseOpenTelescopeLSPChange",
			"TextCaseStartReplacingCommand",
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@module 'snacks'
		---@type snacks.Config
		opts = {
			animate = { enabled = false },
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				sections = {
					{ section = "terminal", cmd = "fortune -s | cowsay", hl = "header", padding = 1, indent = 8 },
					{ section = "startup" },
				},
			},
			dim = { enabled = false },
			git = { enabled = true },
			gitbrowse = { enabled = true },
			indent = {
				enabled = false,
				animate = {
					enabled = false,
				},
			},
			input = {
				prompt_pos = "left",
				icon_pos = "left",
				expand = false,
				icon = "",
			},
			styles = {
				input = {
					border = "none",
					row = -1,
					width = 0,
				},
			},
			notifier = { enabled = false },
			quickfile = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = {
				enabled = false,
				folds = {
					open = true, -- show open fold icons
					git_hl = true, -- use Git Signs hl for fold icons
				},
			},
			words = { enabled = true },
			zen = { enabled = false },
		},
	},
}

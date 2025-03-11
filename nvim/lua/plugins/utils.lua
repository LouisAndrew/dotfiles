return {
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
		dependencies = {
			{
				"stevearc/quicker.nvim",
				event = "FileType qf",
				---@module "quicker"
				---@type quicker.SetupOptions
				opts = {},
			},
		},
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
		"jghauser/mkdir.nvim",
	},
	{
		"mistweaverco/kulala.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("kulala").run()
				end,
				desc = "Send request",
			},
			{ "<leader>Ra", desc = "Send all requests" },
			{ "<leader>Rb", desc = "Open scratchpad" },
		},
		ft = { "http", "rest" },
		opts = {
			-- your configuration comes here
			global_keymaps = false,
		},
	},
	{
		"echasnovski/mini.hipatterns",
		version = "*",
		desc = "Highlight patterns, avoid using `syn match`",
		opts = {
			highlighters = {
				md_stuff = {
					pattern = function(buf_id)
						if vim.bo[buf_id].filetype ~= "markdown" then
							return nil
						end
						return "@%l+%-?%l+"
					end,
					extmarks_opts = {
						priority = 1,
					},
					group = "MiniHipatternsMdStuff",
				},
				todo = {
					pattern = {
						"@todo",
						"@TODO",
					},
					extmarks_opts = {
						priority = 10,
					},
					group = "MiniHipatternsTodo",
				},
				md_done = {
					pattern = {
						"@done",
						"@DONE",
					},
					extmarks_opts = {
						priority = 10,
					},
					group = "MiniHipatternsMdDone",
				},
				md_date = {
					pattern = function(buf_id)
						if vim.bo[buf_id].filetype ~= "markdown" then
							return nil
						end
						return "@%d%d%d%d%-%d%d%-%d%d"
					end,
					extmarks_opts = {
						priority = 10,
					},
					group = "MiniHipatternsMdDate",
				},
			},
		},
	},
}

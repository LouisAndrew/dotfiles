local utils = require("utils")
local enable_copilot = utils.CONST.leet_arg ~= vim.fn.argv(0, -1)

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = enable_copilot and "InsertEnter" or {},
		desc = "Completion / suggestion",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = false,
					hide_during_completion = false,
					keymap = {
						accept = "<M-l>",
						next = "<M-j>",
						prev = "<M-k>",
						dismiss = "<M-h>",
					},
				},
				filetypes = {
					markdown = true,
					snacks_input = false,
				},
			})
		end,
	},
	{
		"yetone/avante.nvim",
		version = false,
		build = "make BUILD_FROM_SOURCE=true",
		lazy = false,
		config = function()
			require("avante").setup({
				provider = "bedrock",
				bedrock = {
					model = "anthropic.claude-3-5-sonnet-20240620-v1:0",
				},
				auto_suggestions_provider = "claude",
			})
		end,
	},
	{
		-- https://github.com/olimorris/codecompanion.nvim
		"olimorris/codecompanion.nvim",
		cmd = {
			"CodeCompanionChat",
			"CodeCompanionToggle",
			"CodeCompanionActions",
			"CodeCompanionAdd",
		},
		keys = {
			-- { mode = { "n", "v" }, "<leader>aa", "<cmd>:CodeCompanionChat<CR>" },
			-- { "<leader>al", "<cmd>:CodeCompanion " },
			-- { mode = { "n", "v" }, "<leader>ax", "<cmd>:CodeCompanionActions<CR>" },
			-- { "<leader>an", "<cmd>:CodeCompanionAdd<CR>" },
		},
		config = true,
		---@module 'CodeCompanion'
		opts = {
			display = {
				chat = {
					window = {
						width = 0.3,
					},
					---@param tokens number
					---@param adapter CodeCompanion.Adapter
					token_count = function(tokens, adapter)
						return " [ " .. tokens .. "@" .. adapter.name .. " ]"
					end,
				},
			},
			strategies = {
				chat = {
					adapter = "anthropic",
					keymaps = {
						next_chat = {
							modes = {
								n = "]a",
							},
						},
						previous_chat = {
							modes = {
								n = "[a",
							},
						},
					},
				},
				inline = {
					adapter = "copilot",
				},
			},
		},
	},
}

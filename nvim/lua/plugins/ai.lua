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
				ollama = {
					model = "deepseek-r1",
					api_key_name = "",
				},
			})
		end,
	},
}

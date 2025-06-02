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
						accept = "<C-l>",
						next = "<C-j>",
						prev = "<C-k>",
						dismiss = "<C-h>",
					},
				},
				filetypes = {
					markdown = true,
					snacks_input = false,
				},
			})

			vim.keymap.set("n", "<leader>at", require("copilot.suggestion").toggle_auto_trigger, {
				desc = "toggle copilot auto trigger",
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		cmd = {
			"CodeCompanionChat",
			"CodeCompanionToggle",
			"CodeCompanionActions",
			"CodeCompanionAdd",
		},
		keys = {
			{ mode = { "n", "v" }, "<leader>aa", "<cmd>:CodeCompanionChat<CR>" },
			{ mode = { "n", "v" }, "<leader>ax", "<cmd>:CodeCompanionActions<CR>" },
			{ "<leader>an", "<cmd>:CodeCompanionAdd<CR>" },
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
						return " [ " .. tokens .. "@" .. adapter.name .. "/" .. adapter.model.name .. " ]"
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
			adapters = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						schema = {
							model = {
								default = "claude-3-5-sonnet-20241022",
							},
						},
					})
				end,
			},
		},
	},
	{
		-- not now
		"yetone/avante.nvim",
		enabled = false,
		version = false,
		build = "make BUILD_FROM_SOURCE=true",
		lazy = false,
		config = function()
			require("avante").setup({
				provider = "claude",
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

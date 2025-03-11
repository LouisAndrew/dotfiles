local utils = require("utils")
local enable_copilot = utils.CONST.leet_arg ~= vim.fn.argv(0, -1)

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = enable_copilot and "InsertEnter" or {},
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
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
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		keys = {
			{ "<leader>ac", "<cmd>:CopilotChat<CR>", mode = { "n", "v" } },
			{
				"<leader>pa",
				function()
					require("CopilotChat").select_prompt()
				end,
				mode = { "n", "v" },
				desc = "CopilotChat - Prompt actions",
			},
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			highlight_headers = false,
			separator = "",
			question_header = "# User ",
			answer_header = "# Copilot ",
			error_header = "# Error ",
			window = {
				width = 0.3,
			},
			mappings = {
				complete = {
					insert = "<C-i>",
				},
				reset = {
					normal = "<C-r>",
					insert = "<C-r>",
				},
			},
			model = "claude-3.5-sonnet",
		},
		lazy = false,
	},
	{
		"yetone/avante.nvim",
		version = false,
		build = "make BUILD_FROM_SOURCE=true",
		dependencies = {
			{
				url = "https://gitlab.com/msvechla/avante-provider-bedrock.nvim.git",
			},
		},
		cmd = "AvanteAsk",
		config = function()
			require("avante_provider_bedrock").setup({
				-- default config
				model = "anthropic.claude-3-5-sonnet-20240620-v1:0",
				profile = "bedrock",
				region = "eu-central-1",
				max_tokens = 4096,
				temperature = 0.6,
				top_p = 1,
				antropic_version = "bedrock-2023-05-31",
			})
			require("avante").setup({
				provider = "bedrockcustom",
				vendors = {
					bedrockcustom = require("avante_provider_bedrock").vendor(),
				},
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
			{ modes = { "n", "v" }, "<leader>aa", "<cmd>:CodeCompanionChat<CR>" },
			{ "<leader>al", "<cmd>:CodeCompanion " },
			{ modes = { "n", "v" }, "<leader>ax", "<cmd>:CodeCompanionActions<CR>" },
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

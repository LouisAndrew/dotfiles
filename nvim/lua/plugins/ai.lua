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
		dependencies = {
			{
				"ravitemer/mcphub.nvim",
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
				build = "pnpm add -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
				config = function()
					require("mcphub").setup()
				end,
			},
			{
				"echasnovski/mini.diff",
				config = function()
					local diff = require("mini.diff")
					diff.setup({
						source = diff.gen_source.none(),
					})
				end,
			},
		},
		keys = {
			{ mode = { "n", "v" }, "<leader>aa", "<cmd>:CodeCompanionChat<CR>" },
			{ mode = { "n", "v" }, "<leader>ax", "<cmd>:CodeCompanionActions<CR>" },
		},
		config = true,
		opts = {
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						show_result_in_chat = true, -- Show mcp tool results in chat
						make_vars = true, -- Convert resources to #variables
						make_slash_commands = true, -- Add prompts as /slash commands
					},
				},
			},
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
				action_palette = {
					provider = "snacks",
				},
			},
			strategies = {
				chat = {
					-- adapter = "anthropic",
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
						change_adapter = {
							modes = {
								n = "gra",
							},
						},
					},
					slash_commands = {
						file = {
							opts = {
								provider = "snacks",
							},
						},
						buffer = {
							opts = {
								provider = "snacks",
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
				bedrock = require("ai.bedrock_adapter"),
			},
		},
	},
	{
		"yetone/avante.nvim",
		keys = {
			"AvanteAsk",
		},
		version = false,
		opts = {
			provider = "bedrock",
			selector = {
				provider = "snacks",
			},
			providers = {
				bedrock = {
					model = "eu.anthropic.claude-3-7-sonnet-20250219-v1:0",
					aws_profile = "bedrock",
					aws_region = "eu-central-1",
				},
			},
		},
		build = "make",
		dependencies = {
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
					},
				},
			},
		},
	},
}

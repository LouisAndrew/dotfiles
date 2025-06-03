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
		enabled = false,
		dependencies = {
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
		cmd = {
			"CodeCompanionChat",
			"CodeCompanionToggle",
			"CodeCompanionActions",
			"CodeCompanionAdd",
		},
		keys = {
			{ mode = { "n", "v" }, "<leader>aa", "<cmd>:CodeCompanionChat<CR>" },
			{ mode = { "n", "v" }, "<leader>ax", "<cmd>:CodeCompanionActions<CR>" },
		},
		config = true,
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
			},
		},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "claude",
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

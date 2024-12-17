return {
	{
		"github/copilot.vim",
		enabled = false,
		lazy = false,
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					keymap = {
						accept = "<Tab>",
						next = "<M-l>",
						prev = "<M-h>",
						dismiss = "<M-j>",
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
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			branch = "main",
			keys = {
				{ "<leader>ac", "<cmd>:CopilotChat<CR>", mode = { "n", "v" } },
				{
					"<leader>pa",
					function()
						local ac = require("CopilotChat.actions")
						require("CopilotChat.integrations.telescope").pick(ac.prompt_actions())
					end,
					mode = { "n", "v" },
					desc = "CopilotChat - Prompt actions",
				},
			},
			dependencies = {
				{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
				{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
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
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = false,
		lazy = false,
		keys = {
			"<leader>av",
			":Avante<CR>",
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
		},
		config = function()
			require("avante_lib").load()
			require("avante").setup({
				provider = "claude",
				auto_suggestions_provider = "copilot", -- expensive
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-3-5-sonnet-20240620",
					temperature = 0,
					max_tokens = 4096,
				},
				behaviour = {
					auto_suggestions = false,
					auto_set_highlight_group = true,
					auto_set_keymaps = true,
					auto_apply_diff_after_generation = false,
					support_paste_from_clipboard = false,
				},
				mappings = {
					--- @class AvanteConflictMappings
					diff = {
						ours = "co",
						theirs = "ct",
						all_theirs = "ca",
						both = "cb",
						cursor = "cc",
						next = "]x",
						prev = "[x",
					},
					suggestion = {
						accept = "<Tab>",
						next = "<C-d>",
						prev = "<C-a>",
						-- dismiss = "<C-q>",
					},
					jump = {
						next = "]]",
						prev = "[[",
					},
					submit = {
						normal = "<CR>",
						-- insert = "<C-s>",
					},
					sidebar = {
						switch_windows = "<Tab>",
						reverse_switch_windows = "<S-Tab>",
					},
				},
				hints = { enabled = true },
				windows = {
					---@type "right" | "left" | "top" | "bottom"
					position = "right", -- the position of the sidebar
					wrap = true, -- similar to vim.o.wrap
					width = 25, -- default % based on available width
					sidebar_header = {
						align = "center", -- left, center, right for title
						rounded = true,
					},
				},
				highlights = {
					---@type AvanteConflictHighlights
					diff = {
						current = "DiffText",
						incoming = "DiffAdd",
					},
				},
				--- @class AvanteConflictUserConfig
				diff = {
					autojump = true,
					---@type string | fun(): any
					list_opener = "copen",
				},
			})
		end,
	},
	{
		-- https://github.com/olimorris/codecompanion.nvim
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
				opts = {},
			},
			"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
		},
		cmd = {
			"CodeCompanionChat",
			"CodeCompanionToggle",
			"CodeCompanionActions",

			"CodeCompanionAdd",
		},
		keys = {
			{ "<leader>ap", "<cmd>:CodeCompanionChat<CR>" },
			{ "<leader>aa", "<cmd>:CodeCompanionToggle<CR>" },
			{ "<leader>al", "<cmd>:CodeCompanion " },
			{ "<leader>ax", "<cmd>:CodeCompanionActions<CR>" },
			{ "<leader>an", "<cmd>:CodeCompanionAdd<CR>" },
		},
		config = true,
		opts = {
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

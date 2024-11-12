return {
	{
		"github/copilot.vim",
		lazy = false,
	},
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	lazy = true,
	-- 	keys = {
	-- 		"<leader>aa",
	-- 		":Avante<CR>",
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("avante_lib").load()
	-- 		require("avante").setup({
	-- 			provider = "openai", -- Recommend using Claude
	-- 			auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
	-- 			claude = {
	-- 				endpoint = "https://api.anthropic.com",
	-- 				model = "claude-3-5-sonnet-20240620",
	-- 				temperature = 0,
	-- 				max_tokens = 4096,
	-- 			},
	-- 			behaviour = {
	-- 				auto_suggestions = false, -- Experimental stage
	-- 				auto_set_highlight_group = true,
	-- 				auto_set_keymaps = true,
	-- 				auto_apply_diff_after_generation = false,
	-- 				support_paste_from_clipboard = false,
	-- 			},
	-- 			mappings = {
	-- 				--- @class AvanteConflictMappings
	-- 				diff = {
	-- 					ours = "co",
	-- 					theirs = "ct",
	-- 					all_theirs = "ca",
	-- 					both = "cb",
	-- 					cursor = "cc",
	-- 					next = "]x",
	-- 					prev = "[x",
	-- 				},
	-- 				suggestion = {
	-- 					accept = "<M-l>",
	-- 					next = "<M-]>",
	-- 					prev = "<M-[>",
	-- 					dismiss = "<C-]>",
	-- 				},
	-- 				jump = {
	-- 					next = "]]",
	-- 					prev = "[[",
	-- 				},
	-- 				submit = {
	-- 					normal = "<CR>",
	-- 					insert = "<C-s>",
	-- 				},
	-- 				sidebar = {
	-- 					switch_windows = "<Tab>",
	-- 					reverse_switch_windows = "<S-Tab>",
	-- 				},
	-- 			},
	-- 			hints = { enabled = true },
	-- 			windows = {
	-- 				---@type "right" | "left" | "top" | "bottom"
	-- 				position = "right", -- the position of the sidebar
	-- 				wrap = true, -- similar to vim.o.wrap
	-- 				width = 50, -- default % based on available width
	-- 				sidebar_header = {
	-- 					align = "center", -- left, center, right for title
	-- 					rounded = true,
	-- 				},
	-- 			},
	-- 			highlights = {
	-- 				---@type AvanteConflictHighlights
	-- 				diff = {
	-- 					current = "DiffText",
	-- 					incoming = "DiffAdd",
	-- 				},
	-- 			},
	-- 			--- @class AvanteConflictUserConfig
	-- 			diff = {
	-- 				autojump = true,
	-- 				---@type string | fun(): any
	-- 				list_opener = "copen",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		-- https://github.com/olimorris/codecompanion.nvim
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
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
			{ "<leader>ac", "<cmd>:CodeCompanionChat<CR>" },
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

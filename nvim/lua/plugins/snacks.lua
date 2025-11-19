---@diagnostic disable: param-type-mismatch
local VAULT = os.getenv("VAULT_PATH")
local utils = require("utils")

vim.api.nvim_create_user_command("PickFiles", function()
	Snacks.picker.files({
		-- dotfiles, but not hidden (in gitignore)
		hidden = true,
	})
end, {})

vim.api.nvim_create_user_command("Grep", function()
	Snacks.picker.grep()
end, {})

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<C-o>",
				"<cmd>:PickFiles<cr>",
				desc = "Find Files",
			},
			{
				"<leader><space>",
				"<cmd>:PickFiles<cr>",
				desc = "Find Files",
			},
			{
				"<leader>,",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>:",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>n",
				function()
					Snacks.picker.notifications()
				end,
				desc = "Notification History",
			},
			{
				"<leader>e",
				function()
					Snacks.explorer({
						hidden = true,
						win = {
							list = {
								keys = {
									["<C-l>"] = { "<C-w>l", expr = true },
									["<C-h>"] = { "<C-w>h", expr = true },
									["<leader>w"] = { "<cmd>:q<CR>", expr = true },
								},
							},
						},
					})
				end,
				desc = "File Explorer",
			},
			-- find
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent",
			},
			-- git
			{
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<leader>gd",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},
			-- Grep
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers",
			},
			{
				"<C-f>",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			-- search
			{
				'<leader>s"',
				function()
					Snacks.picker.registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>s/",
				function()
					Snacks.picker.search_history()
				end,
				desc = "Search History",
			},
			{
				"<leader>sa",
				function()
					Snacks.picker.autocmds()
				end,
				desc = "Autocmds",
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>sC",
				function()
					Snacks.picker.commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>sD",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				function()
					Snacks.picker.highlights()
				end,
				desc = "Highlights",
			},
			{
				"<leader>si",
				function()
					Snacks.picker.icons()
				end,
				desc = "Icons",
			},
			{
				"<leader>sj",
				function()
					Snacks.picker.jumps()
				end,
				desc = "Jumps",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>sl",
				function()
					Snacks.picker.loclist()
				end,
				desc = "Location List",
			},
			{
				"<leader>sm",
				function()
					Snacks.picker.marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>sM",
				function()
					Snacks.picker.man()
				end,
				desc = "Man Pages",
			},
			{
				"<leader>sp",
				function()
					Snacks.picker.lazy()
				end,
				desc = "Search for Plugin Spec",
			},
			{
				"<leader>sq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix List",
			},
			{
				"<leader>sR",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume",
			},
			{
				"<leader>su",
				function()
					Snacks.picker.undo({
						win = {
							input = {
								keys = {
									["<c-i>"] = { "yank_add", mode = { "n", "i" } },
									["<c-a>"] = { "yank_del", mode = { "n", "i" } },
								},
							},
						},
					})
				end,
				desc = "Undo History",
			},
			{
				"<leader>uC",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes",
			},
			-- LSP
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
		},
		---@module 'snacks'
		---@type snacks.Config
		opts = {
			animate = { enabled = false },
			bigfile = { enabled = true },
			dim = { enabled = false },
			git = { enabled = true },
			gitbrowse = { enabled = true },
			indent = {
				enabled = false,
				animate = {
					enabled = false,
				},
			},
			image = {
				enabled = true,
				resolve = function(file, src)
					if file:find(VAULT, 1, true) then
						return VAULT .. "/assets/imgs/" .. src
					end
				end,
				doc = {
					inline = false,
					float = true,
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
				image = {
					border = false,
					col = -1,
					row = -1,
					relative = "editor",
					minimal = true,
					position = "bottom",
				},
			},
			notifier = { enabled = false },
			quickfile = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			picker = {
				enabled = true,
				sources = {
					explorer = {
						layout = {
							layout = {
								position = "right",
							},
						},
					},
					select = {
						layout = {
							layout = {
								backdrop = true,
							},
						},
					},
				},
				matcher = {
					frecency = true,
				},
				win = {
					input = {
						keys = {
							["<c-j>"] = { "edit_split", mode = { "i", "n" } },
							["<c-l>"] = { "edit_vsplit", mode = { "i", "n" } },
							["<c-r>"] = { "toggle_hidden", mode = { "i", "n" } },
							["<c-g>"] = { "toggle_ignored", mode = { "i", "n" } },
							["≥"] = { "toggle_hidden", mode = { "i", "n" } },
							["÷"] = { "toggle_ignored", mode = { "i", "n" } },
							["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
							["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
						},
					},
					list = {
						keys = {
							["<c-j>"] = { "<c-j>", expr = true, desc = "move down" },
							["<c-l>"] = { "<c-l>", expr = true, desc = "move right" },
							["<c-r>"] = { "toggle_hidden", mode = { "i", "n" } },
							["<c-g>"] = { "toggle_ignored", mode = { "i", "n" } },
							["≥"] = { "toggle_hidden", mode = { "i", "n" } },
							["÷"] = { "toggle_ignored", mode = { "i", "n" } },
							["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
							["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
						},
					},
				},
				layouts = {
					custom = {
						layout = {
							box = "horizontal",
							width = 0.8,
							min_width = 120,
							height = 0.8,
							{
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
							{ win = "preview", border = "solid", width = 0.6 },
						},
					},
				},
				layout = {
					preset = "custom",
				},
				ui_select = true,
				icons = {
					ui = {
						selected = "* ",
						unselected = "  ",
					},
				},
			},
			words = { enabled = true },
			zen = { enabled = false },
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		---@module 'which-key'
		---@type wk.Config
		opts = {
			preset = "helix",
			delay = function(ctx)
				return ctx.plugin and 0 or 1000
			end,
			win = {
				border = utils.CONST.border,
				title = false,
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}

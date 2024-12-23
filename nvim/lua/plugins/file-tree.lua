return {
	{
		"stevearc/oil.nvim",
		keys = {
			{ "-", "<cmd>:Oil --float<cr>" },
		},
		--- @module 'oil'
		--- @type oil.Config
		opts = {
			default_file_explorer = true,
			view_options = {},
			float = {
				padding = 0,
			},
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				statuscolumn = "",
				foldcolumn = "0",
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-l>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
				["<C-j>"] = {
					"actions.select",
					opts = { horizontal = true },
					desc = "Open the entry in a horizontal split",
				},
				["<C-w>"] = { "actions.close" },
				["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["="] = "actions.parent",
				["+"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		},
	},
}

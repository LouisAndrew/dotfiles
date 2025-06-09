return {
	"NeogitOrg/neogit",
	lazy = false,
	keys = {
		{ "<leader>gd", "<cmd>:DiffviewOpen<cr>" },
		{ "<leader>go", "<cmd>:DiffviewOpen<cr>" },
		{ "<C-g>", "<cmd>:DiffviewOpen<cr>" },
		{ "<leader>gh", "<cmd>:DiffviewFileHistory %<cr>" },
		{ "<leader>ga", "<cmd>:DiffviewFileHistory<cr>" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	config = function()
		local icons = require("theme.icons")
		---@module 'diffview'
		require("diffview").setup(
			---@type DiffviewConfig
			{
				icons = {
					folder_closed = icons.FolderClosed,
					folder_open = icons.FolderOpened,
				},
				signs = {
					fold_closed = icons.ArrowClosed,
					fold_open = icons.ArrowOpened,
					done = "✓",
				},
			}
		)
		local set = vim.opt -- set options
		set.fillchars = set.fillchars + "diff: "

		local neogit = require("neogit")
		neogit.setup({
			integrations = {
				telescope = false,
				diffview = true,
			},
			mappings = {
				popup = {
					["?"] = "HelpPopup",
					["A"] = "CherryPickPopup",
					["D"] = "DiffPopup",
					["M"] = "RemotePopup",
					["P"] = "PushPopup",
					["X"] = "ResetPopup",
					["Z"] = "StashPopup",
					["b"] = "BranchPopup",
					["c"] = "CommitPopup",
					["f"] = "FetchPopup",
					["l"] = "LogPopup",
					["m"] = "MergePopup",
					["p"] = "PullPopup",
					["r"] = "RebasePopup",
					["v"] = "RevertPopup",
				},
			},
		})
	end,
}

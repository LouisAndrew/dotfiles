local icons = require("theme.icons")

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufEnter", "BufWinEnter" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("lsp")
		end,
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		keys = {
			{ "<leader>it", "<cmd>:Outline<cr>" },
		},
		opts = {
			keymaps = {
				fold_toggle = "za",
				down_and_jump = "<C-n>",
				up_and_jump = "<C-p>",
				fold_all = "zM",
				unfold_all = "zR",
			},
			symbols = {
				icons = require("theme.outline-icons"),
			},
		},
		desc = "Outline",
	},

	{
		"b0o/SchemaStore.nvim",
		ft = { "json", "toml", "yaml" },
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		dependencies = { "Bilal2453/luvit-meta", lazy = true },
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
}

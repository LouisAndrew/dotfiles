local icons = require("theme.icons")

return {
	"VonHeikemen/lsp-zero.nvim",
	event = { "BufEnter", "BufWinEnter" },
	branch = "v4.x",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		{
			"rmagatti/goto-preview",
			event = "BufEnter",
			config = true,
			keys = {
				{ "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>" },
				{ "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>" },
				{ "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>" },
			},
			desc = "definition preview in a floating window",
		},
		{
			"zeioth/garbage-day.nvim",
			event = "VeryLazy",
			opts = {},
			desc = "Auto-close LSP",
		},
		{
			"stevearc/conform.nvim",
			lazy = true,
			desc = "Formatter",
		},
		{
			"SmiteshP/nvim-navic",
			opts = {
				icons = icons,
				depth_limit = 4,
				highlight = true,
				---@param text string
				format_text = function(text)
					return text:gsub("callback", "cb")
				end,
				lsp = {
					preference = { "volar" },
					auto_attach = true,
				},
			},
			desc = "Breadcrumbs",
		},
		{
			"kevinhwang91/nvim-ufo",
			dependencies = {
				"kevinhwang91/promise-async",
			},
			desc = "Folds",
		},
		-- json schema
		"b0o/SchemaStore.nvim",
		{
			"yioneko/nvim-vtsls",
			desc = "TS LSP",
		},
		{
			-- Lua LSP
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true },
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
	},
	config = function()
		require("lsp")
	end,
}

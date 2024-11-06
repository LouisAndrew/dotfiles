local icons = require("theme.icons")
return {
	"VonHeikemen/lsp-zero.nvim",
	-- event = "BufEnter",
	branch = "v3.x",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- LSP Support
		"neovim/nvim-lspconfig",
		-- Autocompletion
		{
			-- Auto-close LSP
			"zeioth/garbage-day.nvim",
			event = "VeryLazy",
			opts = {},
		},
		{
			-- Formatting
			"stevearc/conform.nvim",
			dependencies = { "mason.nvim" },
			lazy = true,
		},
		{
			-- Completion
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
				-- Snippets: TBD, not sure what to do here
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
			},
		},
		-- Debugging
		{
			"folke/trouble.nvim",
			lazy = true,
			keys = { { "<leader>id", "<cmd>:TroubleToggle<cr>" } },
			config = function()
				require("trouble").setup({ auto_preview = false })
			end,
		},
		{
			-- Breadcrumbs
			"SmiteshP/nvim-navic",
			config = function()
				require("nvim-navic").setup({
					icons = icons,
					depth_limit = 4,
					highlight = true,
					---@param text string
					format_text = function(text)
						return text:gsub("callback", "cb")
					end,
					lsp = {
						preference = { "volar" },
					},
				})
			end,
		},
		{
			-- Folds
			"kevinhwang91/nvim-ufo",
			dependencies = {
				"kevinhwang91/promise-async",
				{
					"chrisgrieser/nvim-origami",
					event = "BufReadPost", -- later or on keypress would prevent saving folds
					config = function()
						require("origami").setup({
							keepFoldsAcrossSessions = true,
							pauseFoldsOnSearch = true,
							setupFoldKeymaps = false,
						})
					end,
				},
			},
		},
		-- json schema
		"b0o/SchemaStore.nvim",
		-- TS LSP
		"yioneko/nvim-vtsls",
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
		-- Symbols outline
		{
			"hedyhli/outline.nvim",
			lazy = true,
			keys = {
				{ "n", "<leader>it", "<cmd>:Outline<cr>" },
			},
			opts = {},
		},
	},
	config = function()
		require("lsp")
	end,
}

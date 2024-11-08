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
					icons = {
						File = { icon = icons.File },
						Module = { icon = icons.Constructor, hl = "Include" },
						Namespace = { icon = icons.Namespace, hl = "Include" },
						Package = { icon = icons.Package, hl = "Include" },
						Class = { icon = icons.Class, hl = "Type" },
						Method = { icon = icons.Function, hl = "Function" },
						Property = { icon = icons.Property, hl = "Identifier" },
						Field = { icon = icons.Property, hl = "Identifier" },
						Constructor = { icon = icons.Constructor, hl = "Special" },
						Enum = { icon = icons.Enum, hl = "Type" },
						Interface = { icon = icons.Interface, hl = "Type" },
						Function = { icon = icons.Function },
						Variable = { icon = icons.Variable, hl = "Constant" },
						Constant = { icon = icons.Constant, hl = "Constant" },
						String = { icon = icons.String, hl = "String" },
						Number = { icon = icons.Number, hl = "Number" },
						Boolean = { icon = icons.Boolean, hl = "Boolean" },
						Array = { icon = icons.Array, hl = "Constant" },
						Object = { icon = icons.Object, hl = "Type" },
						Key = { icon = icons.Key, hl = "Type" },
						Null = { icon = icons.Null, hl = "Type" },
						EnumMember = { icon = icons.EnumMember, hl = "Identifier" },
						Struct = { icon = icons.Struct, hl = "Structure" },
						Event = { icon = icons.Event, hl = "Type" },
						Operator = { icon = icons.Operator, hl = "Identifier" },
						TypeParameter = { icon = icons.TypeParameter, hl = "Identifier" },
						Component = { icon = icons.Module, hl = "Function" },
						Fragment = { icon = icons.Module, hl = "Constant" },
						TypeAlias = { icon = icons.TypeParameter, hl = "Type" },
						Parameter = { icon = icons.TypeParameter, hl = "Identifier" },
						StaticMethod = { icon = icons.Function, hl = "Function" },
						Macro = { icon = " ", hl = "Function" },
					},
				},
			},
		},
	},
	config = function()
		require("lsp")
	end,
}

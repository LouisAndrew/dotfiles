local icons = require("theme.icons")

return {
	{
		-- Completion
		"hrsh7th/nvim-cmp",
		enabled = false, -- trying out blink.cmp
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
	{
		"saghen/blink.cmp",
		lazy = false,
		build = "cargo build --release",
		branch = "main",
		event = "InsertEnter",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			completion = {
				list = {
					selection = "manual",
				},
			},
			appearance = {
				kind_icons = icons,
				nerd_font_variant = "normal",
				use_nvim_cmp_as_default = false,
			},
			keymap = {
				["<C-e>"] = { "show", "hide" },
				["<CR>"] = { "accept", "fallback" },
				["<Space>"] = { "accept", "fallback" },
				["<C-y>"] = { "show_documentation", "hide_documentation" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},
			sources = {
				default = { "lsp", "path", "snippets", "luasnip" },
				cmdline = function()
					local type = vim.fn.getcmdtype()
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					if type == ":" then
						return { "cmdline" }
					end
					return {}
				end,
			},
		},
		opts_extend = { "sources.default" },
	},
}

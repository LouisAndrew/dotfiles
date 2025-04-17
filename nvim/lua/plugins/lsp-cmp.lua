local icons = require("theme.icons")
local utils = require("utils")

local blink_keymap = {
	["<C-e>"] = { "show", "hide" },
	["<CR>"] = { "accept", "fallback" },
	["<Tab>"] = {},
	["<Space>"] = { "accept", "fallback" },
	["<C-r>"] = { "show_documentation", "hide_documentation" },
	["<C-u>"] = { "scroll_documentation_up", "fallback" },
	["<C-d>"] = { "scroll_documentation_down", "fallback" },
}

return {
	{
		"saghen/blink.cmp",
		lazy = false,
		version = "*",
		event = "InsertEnter",
		opts_extend = { "sources.default" },
		config = function()
			---@module 'blink.cmp'
			---@type blink.cmp.Config
			local opts = {
				completion = {
					list = {
						selection = {
							preselect = false,
							auto_insert = false,
						},
					},
					accept = {
						auto_brackets = {
							enabled = false,
						},
					},
					menu = {
						border = utils.CONST.border,
						winblend = utils.CONST.winblend,
						draw = {
							columns = { { "kind_icon", "label" } },
						},
					},
					documentation = {
						window = {
							border = utils.CONST.border,
							winblend = utils.CONST.winblend,
						},
					},
				},
				appearance = {
					kind_icons = icons,
					nerd_font_variant = "normal",
					use_nvim_cmp_as_default = false,
				},
				keymap = blink_keymap,
				snippets = {
					preset = "luasnip",
				},
				cmdline = {
					keymap = blink_keymap,
					completion = {
						list = {
							selection = {
								preselect = false,
								auto_insert = false,
							},
						},
						menu = { auto_show = true },
						ghost_text = { enabled = false },
					},
				},
				sources = {
					default = { "lsp", "path", "snippets" },
					providers = {},
				},
			}
			require("blink.cmp").setup(opts)
		end,
	},
}

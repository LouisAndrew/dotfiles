local icons = require("theme.icons")
local utils = require("utils")

local blink_keymap = {
	["<C-e>"] = { "show", "hide" },
	["<C-r>"] = { "show_documentation", "hide_documentation" },
	["<C-u>"] = { "scroll_documentation_up", "fallback" },
	["<C-d>"] = { "scroll_documentation_down", "fallback" },
}

return {
	"saghen/blink.cmp",
	lazy = false,
	version = "*",
	event = "InsertEnter",
	opts_extend = { "sources.default" },
	opts = {
		completion = {
			accept = {
				auto_brackets = {
					enabled = false,
				},
			},
			menu = {
				border = utils.CONST.border,
				winblend = utils.CONST.winblend,
				draw = {
					columns = { { "kind_icon", padding = 2 }, { "label" } },
				},
			},
			documentation = {
				window = {
					border = utils.CONST.border,
					winblend = utils.CONST.winblend,
				},
			},
			list = { selection = { auto_insert = false, preselect = true } },
		},
		appearance = {
			kind_icons = icons,
			nerd_font_variant = "mono",
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
						preselect = true,
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
	},
}

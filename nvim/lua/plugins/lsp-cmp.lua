local icons = require("theme.icons")

return {
	{
		"saghen/blink.cmp",
		lazy = false,
		build = "cargo build --release",
		branch = "main",
		event = "InsertEnter",
		dependencies = {
			"xzbdmw/colorful-menu.nvim",
		},
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
					menu = {
						draw = {
							columns = { { "kind_icon" }, { "label", gap = 1 } },
							components = {
								label = {
									text = require("colorful-menu").blink_components_text,
									highlight = require("colorful-menu").blink_components_highlight,
								},
							},
						},
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
				snippets = {
					preset = "luasnip",
				},
				sources = {
					default = { "lsp", "path", "snippets" },
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
			}
			require("blink.cmp").setup(opts)
		end,
	},
}

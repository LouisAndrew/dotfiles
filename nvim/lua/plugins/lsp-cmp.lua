local icons = require("theme.icons")
local trigger_text = ";"

return {
	{
		"saghen/blink.cmp",
		lazy = false,
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
					["<Tab>"] = {},
					["<Space>"] = { "accept", "fallback" },
					["<C-r>"] = { "show_documentation", "hide_documentation" },
					["<C-u>"] = { "scroll_documentation_up", "fallback" },
					["<C-d>"] = { "scroll_documentation_down", "fallback" },
				},
				snippets = {
					preset = "luasnip",
				},
				sources = {
					default = { "lsp", "path", "snippets" },
					providers = {
						snippets = {
							name = "snippets",
							enabled = true,
							max_items = 8,
							min_keyword_length = 0,
							module = "blink.cmp.sources.snippets",
							score_offset = 85, -- the higher the number, the higher the priority
							-- Only show snippets if I type the trigger_text characters, so
							-- to expand the "bash" snippet, if the trigger_text is ";" I have to
							should_show_items = function()
								local col = vim.api.nvim_win_get_cursor(0)[2]
								local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
								-- NOTE: remember that `trigger_text` is modified at the top of the file
								return before_cursor:match(trigger_text .. "%w*$") ~= nil
							end,
							-- After accepting the completion, delete the trigger_text characters
							-- from the final inserted text
							transform_items = function(_, items)
								local col = vim.api.nvim_win_get_cursor(0)[2]
								local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
								local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
								if trigger_pos then
									for _, item in ipairs(items) do
										item.textEdit = {
											newText = item.insertText or item.label,
											range = {
												start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
												["end"] = { line = vim.fn.line(".") - 1, character = col },
											},
										}
									end
								end
								-- NOTE: After the transformation, I have to reload the luasnip source
								-- Otherwise really crazy shit happens and I spent way too much time
								-- figurig this out
								vim.schedule(function()
									require("blink.cmp").reload("snippets")
								end)
								return items
							end,
						},
					},
				},
			}
			require("blink.cmp").setup(opts)
		end,
	},
}

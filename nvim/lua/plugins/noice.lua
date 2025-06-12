local icons = require("theme.icons")
local utils = require("utils")

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	branch = "main",
	config = function()
		local noice = require("noice")
		noice.setup({
			cmdline = {
				view = "cmdline",
				enabled = true,
				opts = {},
				format = {
					cmdline = { pattern = "^:", icon = "   ", lang = "vim", title = "" },
					search_down = {
						title = "",
						kind = "search",
						pattern = "^/",
						icon = "   ",
						lang = "regex",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdline",
									FloatBorder = "NoiceCmdline",
								},
							},
						},
					},
					search_up = {
						title = "",
						kind = "search",
						pattern = "^%?",
						icon = " ",
						lang = "regex",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdline",
									FloatBorder = "NoiceCmdline",
								},
							},
						},
					},
					filter = {
						title = "",
						pattern = "^:%s*!",
						icon = "  $ ",
						lang = "bash",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdline",
									FloatBorder = "NoiceCmdline",
								},
							},
						},
					},
					lua = {
						title = "",
						pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
						icon = "   ",
						lang = "lua",
						opts = {
							win_options = {
								winhighlight = {
									Normal = "NoiceCmdline",
									FloatBorder = "NoiceCmdline",
								},
							},
						},
					},
					help = { title = "", pattern = "^:%s*he?l?p?%s+", icon = "  ? " },
					input = {
						opts = {},
					},
				},
			},
			views = {
				notify = {
					merge = true,
				},
				cmdline = {},
				-- %s/hi/mom/gc
				cmdline_popup = {
					relative = "editor",
					position = {
						row = -1,
						col = 1,
					},
					size = {
						width = "100%",
					},
					border = {},
				},
				cmdline_input = {
					border = { style = "none" },
				},
				mini = {},
				hover = {
					border = { style = utils.CONST.border },
					win_options = {
						winblend = utils.CONST.winblend,
					},
				},
				confirm = { border = { style = "single" } },
			},
			notify = {
				enabled = false,
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				signature = {
					enabled = true,
					auto_open = {
						enabled = false,
						trigger = false,
						luasnip = false,
					},
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
			popup_menu = {
				enabled = true,
				backend = "cmp",
			},
			messages = {
				view = "mini",
				view_error = "mini",
				view_warn = "mini",
			},
			format = {
				level = { icons = { error = icons.Error, warn = icons.Warn, info = icons.Info } },
			},
			progress = {
				view = "mini",
			},
			routes = {
				{
					filter = {
						event = "lsp",
						cond = function(message)
							local client = vim.tbl_get(message.opts, "progress", "client")
							return client == "null-ls"
						end,
					},
					opts = {
						skip = true,
					},
				},
			},
		})
	end,
}

local icons = require("theme.icons")
local VAULT = os.getenv("VAULT_PATH")

return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = false,
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			completions = {
				lsp = { enabled = true },
				blink = { enabled = true },
			},
			heading = { enabled = false },
			code = {
				sign = false,
				left_pad = 1,
				language_pad = 1,
			},
			bullet = {
				icons = { "-" },
				right_pad = 1,
			},
			quote = {
				icon = icons.TallVertLine,
			},
			anti_conceal = {
				ignore = { bullet = true },
			},
			callout = {
				update = {
					raw = "[!update]",
					rendered = " Update",
					highlight = "RenderMarkdownUpdate",
				},
				important = {
					highlight = "RenderMarkdownError",
				},
				imp = {
					raw = "[!imp]",
					rendered = "󰅾 Important",
					highlight = "RenderMarkdownError",
				},
			},
			link = {
				custom = {
					web = { pattern = "^http", icon = "" },
					discord = { pattern = "discord%.com", icon = "" },
					github = { pattern = "github%.com", icon = "" },
					gitlab = { pattern = "gitlab%.com", icon = "" },
					google = { pattern = "google%.com", icon = "" },
					neovim = { pattern = "neovim%.io", icon = "" },
					reddit = { pattern = "reddit%.com", icon = "" },
					stackoverflow = { pattern = "stackoverflow%.com", icon = "" },
					wikipedia = { pattern = "wikipedia%.org", icon = "" },
					youtube = { pattern = "youtube%.com", icon = "" },
				},
			},
		},
		keys = {
			{ "<leader>il", "<cmd>:RenderMarkdown toggle<cr>" },
		},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		enabled = false,
		keys = {
			{ "<leader>il", "<cmd>:Markview toggle<CR>" },
		},
		opts = {
			preview = {
				filetypes = { "markdown", "codecompanion", "Avante", "copilot-chat" },
				icon_provider = "devicons",
			},
			markdown_inline = {
				checkboxes = {
					checked = { text = icons.BoxChecked },
					unchecked = { text = icons.Box },
				},
				hyperlinks = {
					default = {
						icon = "",
					},
				},
				internal_links = {
					default = {
						icon = "",
					},
				},
				images = {
					default = {
						icon = "",
					},
				},
				embed_files = {
					default = {
						icon = "",
					},
				},
			},
			markdown = {
				headings = {
					enable = false,
				},
				internal_links = {},
				list_items = {
					indent_size = 2,
					shift_width = 2,
					marker_minus = {
						add_padding = false,
						text = "-",
					},
					marker_star = {
						add_padding = false,
						text = "-",
					},
				},
				code_blocks = {
					style = "block",
					sign = false,
					pad_amount = 1,
					label_direction = "left",
					border_hl = "MarkviewCode",
					info_hl = "MarkviewCodeInfo",
				},
			},
			inline_codes = {
				hl = "MarkviewCodeInline",
				padding_right = "",
				padding_left = "",
			},
			links = {},
			block_quotes = {
				default = {
					border = icons.TallVertLine,
				},
				["INFO"] = {
					hl = "MarkviewBlockQuoteDefault",
					preview = icons.CircleCheck .. " Todo",
					title = true,
					icon = icons.CircleCheck,
					border = icons.TallVertLine,
				},
				["NOTE"] = {
					hl = "MarkviewBlockQuoteNote",
					preview = icons.Bookmark .. " Note",
					title = true,
					icon = icons.CircleCheck,
					border = icons.TallVertLine,
				},
				["QUOTE"] = {
					hl = "MarkviewBlockQuoteNote",
					preview = icons.Bookmark .. " Quote",
					title = true,
					icon = icons.CircleCheck,
					border = icons.TallVertLine,
				},
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"3rd/image.nvim",
		build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
		opts = {
			processor = "magick_cli",
			integrations = {
				html = {
					enabled = true,
				},
				markdown = {
					clear_in_insert_mode = true,
					only_render_image_at_cursor = true,
					only_render_image_at_cursor_mode = "inline",
					floating_windows = true,
					resolve_image_path = function(document_path, image_path, fallback)
						if document_path:find(VAULT, 1, true) then
							return VAULT .. "/assets/imgs/" .. image_path
						end
						return fallback(document_path, image_path)
					end,
				},
			},
		},
	},
}

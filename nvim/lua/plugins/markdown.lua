local icons = require("theme.icons")
local VAULT = os.getenv("VAULT_PATH")

return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		keys = {
			{ "<leader>il", "<cmd>:Markview toggle<CR>" },
		},
		opts = {
			preview = {
				filetypes = { "markdown", "codecompanion", "Avante", "copilot-chat" },
			},
			markdown_inline = {
				checkboxes = {
					checked = { text = icons.BoxChecked },
					unchecked = { text = icons.Box },
				},
			},
			---@type markview.config.markdown
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
			},
			---@type markview.conf.code_blocks
			code_blocks = {
				icons = "devicons",
				style = "block",
				sign = false,
				pad_amount = 2,
				label_direction = "left",
			},
			inline_codes = {
				hl = "MarkviewCodeInline",
				padding_right = "",
				padding_left = "",
			},
			links = {
				hyperlinks = {
					icon = " ",
					custom = {
						{ match_string = "^http[s]?://", icon = " ", highlight = "MarkviewExternalLink" },
					},
				},
				images = {
					icon = " ",
				},
				emails = {
					icon = " ",
				},
				internal_links = {
					icon = " ",
				},
			},
			block_quotes = {
				default = {
					border = icons.TallVertLine,
				},
				["INFO"] = {
					hl = "MarkviewBlockQuoteNote",
					preview = icons.CircleCheck .. " Todo",
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
				markdown = {
					clear_in_insert_mode = true,
					only_render_image_at_cursor = true,
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

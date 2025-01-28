local icons = require("theme.icons")
local VAULT_PATH = os.getenv("VAULT_PATH")
local COMMONPLACE = os.getenv("COMMONPLACE")

return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		keys = {
			{ "<leader>il", "<cmd>:Markview toggle<CR>" },
		},
		opts = {
			filetypes = { "markdown", "codecompanion", "Avante", "copilot-chat" },
			headings = {
				enable = false,
			},
			list_items = {
				enable = false,
			},
			checkboxes = {
				enable = false,
			},
			---@type markview.conf.code_blocks
			code_blocks = {
				icons = "devicons",
				style = "block",
				language_direction = "left",
				sign = false,
				pad_amount = 2,
			},
			inline_codes = {
				hl = "MarkviewCodeInline",
				corner_right = "",
				corner_left = "",
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
				callouts = {
					{
						match_string = "NOTE",
						hl = "MarkviewBlockQuoteNote",
						preview = icons.InfoCircle .. " Note",
						border = icons.TallVertLine,
					},
					{
						match_string = "TODO",
						hl = "MarkviewBlockQuoteNote",
						preview = icons.CircleCheck .. " Todo",
						title = true,
						icon = icons.CircleCheck,
						border = icons.TallVertLine,
					},
					{
						match_string = "INFO",
						hl = "MarkviewBlockQuoteNote",
						preview = icons.InfoCircle .. " Info",
						custom_title = true,
						icon = icons.CircleCheck,
						border = icons.TallVertLine,
					},
					{
						match_string = "TLDR",
						hl = "MarkviewBlockQuoteNote",
						preview = icons.Clippy .. " Tldr",
						title = true,
						icon = icons.Clippy,
						border = icons.TallVertLine,
					},
				},
			},
		},
	},
	{
		"epwalsh/obsidian.nvim",
		lazy = false,
		ft = "markdown",
		keys = {
			{ "<leader>lO", "<cmd>:ObsidianOpen<cr>" },
			{ "<leader>lo", "<cmd>:ObsidianQuickSwitch<cr>" },
			{ "<leader>lf", "<cmd>:ObsidianSearch<cr>" },
			{ "<leader>lp", "<cmd>:ObsidianPasteImg<cr>" },
			{ "<leader>ll", "<cmd>:ObsidianBacklinks<cr>" },
			{ "<leader>ln", ":ObsidianNew" },
			{ "<leader>ln", ":ObsidianExtractNote", mode = "v" },
			{ "<leader>lg", ":ObsidianLinkNew ", mode = "v" },
			{ "<leader>lw", "<cmd>:ObsidianWorkspace<cr>" },
			{ "<leader>lx", "<cmd>:ObsidianToggleCheckbox<cr>" },
			{ "<leader>lt", "<cmd>:ObsidianTags<CR>" },
			{
				"<leader>lq",
				":e " .. COMMONPLACE .. "<cr>",
				{ expr = true },
			},

			{ "<C-a>", "<cmd>:ObsidianQuickSwitch<cr>" },
			{ "<C-v>", "<cmd>:ObsidianSearch<cr>" },
			{
				"<C-q>",
				":e " .. COMMONPLACE .. "<cr>",
				{ expr = true },
			},
			{
				"<leader>la",
				function()
					local filename = vim.fn.expand("%:t:r")
					local name = require("textcase").api.to_title_case(filename)

					local pos = vim.api.nvim_win_get_cursor(0)
					local row = pos[1] - 1 -- Convert to 0-based index
					local col = pos[2]

					-- Insert the title at cursor position
					vim.api.nvim_buf_set_text(0, row, col, row, col, { "# " .. name })
				end,
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"godlygeek/tabular",
		},
		config = function()
			local colors = require("minimal_fedu")

			require("obsidian").setup(
				---@module 'obsidian'
				---@type obsidian.config.ClientOpts
				{
					notes_subdir = "notes",
					mappings = {
						["gf"] = {
							action = function()
								return require("obsidian").util.gf_passthrough()
							end,
							opts = { noremap = false, expr = true, buffer = true },
						},
					},
					picker = {
						name = "telescope.nvim",
						note_mappings = {
							["<C-l>"] = "vsplit",
							["<C-c>"] = "new",
						},
						tag_mappings = {
							["<C-l>"] = "vsplit",
							["<C-c>"] = "new",
						},
					},
					ui = {
						bullets = { char = "-", hl_group = "ObsidianBullet" },
						reference_text = { hl_group = "ObsidianRefText" },
						highlight_text = { hl_group = "ObsidianHighlightText" },
						tags = { hl_group = "ObsTag" },
						external_link_icon = {
							char = "",
							hl_group = "ObsidianExtLinkIcon",
						},
						checkboxes = {
							[" "] = { char = icons.Circle, hl_group = "ObsidianTodo" },
							["x"] = { char = icons.CircleCheck, hl_group = "ObsidianDone" },
							[">"] = { char = "", hl_group = "ObsidianRightArrow" },
							["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
						},
						hl_groups = {
							ObsidianRefText = { fg = colors.cyan },
							ObsidianHighlightText = { fg = colors.debug },
							ObsidianTag = { fg = colors.palette.blue_fg, bg = colors.palette.blue },
							ObsidianExtLinkIcon = { fg = colors.navy },
							ObsidianBullet = { bold = false, fg = colors.dimmed_white },
						},
					},
					workspaces = {
						{
							name = "icloud",
							path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault",
						},
						-- keeping this for backup for now
						{
							name = "personal",
							path = "~/dev/documents",
						},
					},
					open_app_foreground = true,
					follow_url_func = function(url)
						vim.fn.jobstart({ "open", url })
					end,
					attachments = {
						img_folder = "imgs",
					},
					sort_by = "modified",
					sort_reversed = true,
					note_frontmatter_func = function(note)
						local now = os.date("%Y-%m-%d")
						local out =
							{ id = note.id, aliases = note.aliases, tags = note.tags, created = now, modified = now }

						if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
							for k, v in pairs(note.metadata) do
								out[k] = v

								if k == "modified" then
									out[k] = now
								end
							end
						end

						return out
					end,
					note_id_func = function(title)
						local suffix = ""
						if title ~= nil then
							return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
						end

						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end

						return suffix
					end,
					note_path_func = function(spec)
						local title_lowercased = spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
						-- This is equivalent to the default behavior.
						return title_lowercased .. ".md"
					end,
				}
			)
		end,
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
}

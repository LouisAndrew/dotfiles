local VAULT_PATH = os.getenv("VAULT_PATH")

return {
	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown", "codecompanion", "Avante", "copilot-chat" },
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
			code_blocks = {
				icons = "devicons",
				style = "simple",
				language_direction = "left",
				sign = false,
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
		},
	},
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		ft = "markdown",
		keys = {

			{ "<leader>lo", "<cmd>:ObsidianOpen<cr>" },
			{ "<leader>lf", "<cmd>:ObsidianQuickSwitch<cr>" },
			{ "<leader>ls", "<cmd>:ObsidianSearch<cr>" },
			{ "<leader>lp", "<cmd>:ObsidianPasteImg<cr>" },
			{ "<leader>ll", "<cmd>:ObsidianBacklinks<cr>" },
			{ "<leader>ln", ":ObsidianNew notes/" },
			{ "<leader>lg", ":ObsidianLinkNew ", mode = "v" },
			{ "<leader>lw", "<cmd>:ObsidianWorkspace<cr>" },
			{ "<leader>lx", "<cmd>:ObsidianToggleCheckbox<cr>" },
			{ "<leader>lt", "<cmd>:ObsidianTags<CR>" },
			{
				"<leader>lq",
				":e " .. VAULT_PATH .. "/todos.md<CR>",
				{ expr = true },
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"godlygeek/tabular",
			{
				"ellisonleao/glow.nvim",
				cmd = "Glow",
				config = function()
					require("glow").setup({
						path = "/opt/homebrew/bin/glow",
						border = "rounded", -- floating window border config
						style = "dark", -- filled automatically with your current editor background, you can override using glow json style
						pager = false,
						width = 150,
						height = 300,
						width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
						height_ratio = 0.7,
					})

					vim.keymap.set("n", "<leader>lg", "<cmd>:Glow<cr>", { noremap = true, silent = true })
				end,
			},
		},
		config = function()
			local colors = require("minimal_fedu")

			require("obsidian").setup({
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
						[" "] = { char = "", hl_group = "ObsidianTodo" },
						["x"] = { char = "", hl_group = "ObsidianDone" },
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
					local now = os.date("%d.%m.%Y")
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
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return suffix
				end,
			})
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

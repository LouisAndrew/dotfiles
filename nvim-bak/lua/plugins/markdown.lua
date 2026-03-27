local icons = require("theme.icons")
local VAULT = os.getenv("VAULT_PATH")

return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = false,
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			file_types = { "markdown", "codecompanion" },
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
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}

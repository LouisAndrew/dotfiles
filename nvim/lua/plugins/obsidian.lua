local COMMONPLACE = os.getenv("COMMONPLACE")

return {
	"obsidian-nvim/obsidian.nvim",
	lazy = false,
	priority = 1000,
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
		{ "<C-b>", "<cmd>:ObsidianQuickSwitch<cr>" },
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
					["go"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
				},
				picker = {
					-- snacks picker is not good enough. doesn't filter out assets
					-- and sorting doesn't work correctly
					name = "snacks.pick",
					-- name = "telescope.nvim",
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
					hl_groups = {
						ObsidianTag = { italic = false, fg = colors.palette.indigo[2] },
						ObsidianRefText = { fg = colors.palette.navy[1] },
					},
				},
				workspaces = {
					{
						name = "link",
						path = "~/vault",
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
					img_folder = "assets/imgs",
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

						if string.find(note.path.filename, "scratchbook") and note.metadata["status"] == nil then
							out["status"] = 0
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
					return title_lowercased .. ".md"
				end,
				completion = {
					nvim_cmp = false,
					blink = true,
					min_chars = 1,
				},
			}
		)
	end,
}

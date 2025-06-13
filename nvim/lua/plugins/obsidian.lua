local COMMONPLACE = os.getenv("COMMONPLACE")
local VAULT_PATH = os.getenv("VAULT_PATH")

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
	},
	dependencies = {
		"godlygeek/tabular",
	},
	config = function()
		local obs = require("obsidian")
		obs.setup(
			---@module 'obsidian'
			---@type obsidian.config.ClientOpts
			{
				ui = { enable = false },
				notes_subdir = "notes",
				picker = {
					-- snacks picker is not good enough. doesn't filter out assets
					-- and sorting doesn't work correctly
					name = "snacks.pick",
					note_mappings = {
						["<C-l>"] = "vsplit",
						["<C-c>"] = "new",
					},
					tag_mappings = {
						["<C-l>"] = "vsplit",
						["<C-c>"] = "new",
					},
				},
				workspaces = {
					{
						name = "link",
						path = VAULT_PATH,
					},
				},
				attachments = {
					img_folder = "assets/imgs",
				},
				sort_by = "modified",
				wiki_link_func = "use_alias_only",
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

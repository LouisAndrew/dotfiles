return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"fdschmidt93/telescope-egrepify.nvim",
		"AckslD/nvim-neoclip.lua",
	},
	config = function()
		local builtin = require("telescope.builtin")
		local telescope = require("telescope")
		local config = require("telescope.config")

		local actions = require("telescope.actions")
		local fb_actions = telescope.extensions.file_browser.actions

		local function normalize_path(path)
			return path:gsub("\\", "/")
		end

		local function split_filepath(path)
			local normalized_path = normalize_path(path)

			local paths = {}
			for match in string.gmatch(normalized_path, "[^/]+") do
				table.insert(paths, match)
			end

			local filename = paths[#paths]
			local stripped_path = ""

			if #paths == 1 then
				return "", filename
			end

			local path_limit = 2
			for i = 1, #paths - 1 do
				local path_component = paths[i]
				if #paths - 1 >= path_limit and i < #paths - path_limit - 1 then
					path_component = path_component:sub(1, 1)
				end

				stripped_path = stripped_path .. path_component .. "/"
			end

			return stripped_path, filename
		end

		local function path_display(_, path)
			local stripped_path, filename = split_filepath(path)
			if filename == stripped_path or stripped_path == "" then
				return filename
			end
			return string.format("%s ~ %s", filename, stripped_path)
		end

		require("neoclip").setup()

		local default_maps = {
			i = {
				["<C-l>"] = actions.file_vsplit,
				["<C-j>"] = actions.file_split,
				["<C-u>"] = actions.preview_scrolling_up,
			},
		}

		---@diagnostic disable-next-line: deprecated
		local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

		table.insert(vimgrep_arguments, "--hidden")
		table.insert(vimgrep_arguments, "--glob")
		table.insert(vimgrep_arguments, "!**/.git/*")

		telescope.setup({
			defaults = {
				border = true,
				mappings = default_maps,
				path_display = path_display,
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						width = {
							padding = 0,
						},
						height = {
							padding = 0,
						},
						preview_width = 0.7,
					},
				},
				dynamic_preview_title = true,
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = " ",
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})

		telescope.load_extension("file_browser")
		telescope.load_extension("fzf")
		telescope.load_extension("egrepify")
		telescope.load_extension("undo")
		telescope.load_extension("noice")

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		-- find siblings
		vim.keymap.set("n", "<leader>pj", function()
			builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
		end)
		vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>pc", builtin.grep_string, {})
		vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
		vim.keymap.set("n", "<leader>ps", telescope.extensions.egrepify.egrepify, {})
		vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>py", telescope.extensions.neoclip.default, {})
		vim.keymap.set("n", "<leader>pu", telescope.extensions.undo.undo, {})
		vim.keymap.set("n", "<leader>pe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {})
	end,
}

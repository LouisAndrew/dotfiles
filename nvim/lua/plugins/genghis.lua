return {
	"chrisgrieser/nvim-genghis",
	dependencies = {
		"stevearc/dressing.nvim",
		config = function()
			local special_chars = require("theme.special_chars")
			require("dressing").setup({
				input = {
					win_options = {
						winhighlight = "Normal:cmpmenu,FloatBorder:cmpborder,Search:None",
					},
				},
				select = {
					telescope = {
						layout_strategy = "vertical",
						sorting_strategy = "ascending",
						layout_config = {
							vertical = {
								width = 0.5,
								height = 0.5,
								prompt_position = "top",
							},
						},
					},
				},
			})
		end,
	},
	config = function()
		local keymap = vim.keymap.set
		local genghis = require("genghis")
		genghis.setup({
			backdrop = {
				enabled = false,
			},
		})

		keymap("n", "<leader>yp", genghis.copyFilepath)
		keymap("n", "<leader>yn", genghis.copyFilename)
		keymap("n", "<leader>yf", genghis.duplicateFile)

		keymap("n", "<leader>cx", genghis.chmodx)

		keymap("n", "<leader>rf", genghis.renameFile)
		keymap("n", "<leader>mf", genghis.moveAndRenameFile)
		keymap("n", "<leader>nf", genghis.createNewFile)

		keymap("n", "<leader>df", genghis.trashFile)

		keymap("x", "<leader>x", genghis.moveSelectionToNewFile)
	end,
}

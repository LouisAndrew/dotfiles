return {
	"chrisgrieser/nvim-genghis",
	config = function()
		local keymap = vim.keymap.set
		local genghis = require("genghis")
		genghis.setup({
			backdrop = {
				enabled = true,
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

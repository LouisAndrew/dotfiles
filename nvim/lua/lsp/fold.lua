local utils = require("utils")

---@diagnostic disable: assign-type-mismatch
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 10
vim.o.foldlevelstart = 10
vim.o.foldenable = true

local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = ("  %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "UfoFoldVirtualText" })
	return newVirtText
end

require("ufo").setup({
	open_fold_hl_timeout = 150,
	-- not working with TS provider
	close_fold_kinds_for_ft = {
		default = { "imports", "comment" },
		json = { "array" },
		vue = { "import_statement" },
		go = { "import_declaration" },
		tsplayground = {},
	},
	preview = {
		win_config = {
			border = utils.CONST.border,
			winblend = utils.CONST.winblend,
		},
		mappings = {
			scrollU = "<C-u>",
			scrollD = "<C-d>",
			jumpTop = "[",
			jumpBot = "]",
		},
	},
	provider_selector = function(_, ft)
		if ft == "tsplayground" then
			return { "indent" }
		end

		return { "treesitter", "indent" }
	end,
	fold_virt_text_handler = handler,
})

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeFoldsWith)

vim.keymap.set("n", "z2", function()
	require("ufo").closeFoldsWith(1)
end)

vim.keymap.set("n", "z3", function()
	require("ufo").closeFoldsWith(2)
end)

vim.keymap.set("n", "zn", function()
	require("ufo").closeFoldsWith(1)
end)

vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

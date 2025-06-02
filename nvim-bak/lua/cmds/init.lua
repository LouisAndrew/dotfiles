local utils = require("utils")
local md_group = vim.api.nvim_create_augroup("MD Highlights", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	group = md_group,
	callback = function()
		vim.cmd("syntax match MDDone /@done/")
		vim.cmd("syntax match MDReminder /@REMINDER/")
		vim.cmd("syntax match Bold /\\*\\*.*\\*\\*/")
		vim.keymap.set("n", "J", require("snacks").image.hover)

		local o = vim.opt
		o.tabstop = 2
		o.softtabstop = 2
		o.shiftwidth = 2
	end,
})

local has_value = require("utils").has_value
-- Disable diff and numlines for certain filetypes
local no_statuscol_filetypes = {
	"DiffviewFiles",
	"DiffviewFileHistory",
	"Outline",
	"oil",
}

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if has_value(no_statuscol_filetypes, vim.bo.filetype) then
			vim.wo.statuscolumn = ""
		end
	end,
})

local pasteImg = require("cmds.paste-img")
vim.api.nvim_create_user_command("PasteImgClipboardObsidian", pasteImg, { nargs = "?" })

vim.filetype.add({
	extension = {
		pcss = "scss",
	},
	filename = {},
	pattern = {},
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

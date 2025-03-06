local config = require("config")

local global_group = vim.api.nvim_create_augroup("Global Highlights", { clear = true })
local md_group = vim.api.nvim_create_augroup("MD Highlights", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	group = md_group,
	callback = function()
		vim.cmd("syntax match MDDone /@DONE/")
		vim.cmd("syntax match MDDone /@done/")
		vim.cmd("syntax match MDReminder /@REMINDER/")
		vim.cmd("syntax match MDDate /@\\d\\{2}\\.\\d\\{2}\\.\\d\\{4}/")
		vim.cmd("syntax match MDDate /@\\d\\{2}\\.\\d\\{2}\\.\\d\\{2}/")
		vim.cmd("syntax match MDDate /@\\d\\{4}-\\d\\{2}-\\d\\{2}/")
		vim.cmd("syntax match MDDate /@\\d\\{2}\\.\\d\\{4}/ ")
		vim.cmd("syntax match Bold /\\*\\*.*\\*\\*/")

		local o = vim.opt
		o.tabstop = 2
		o.softtabstop = 2
		o.shiftwidth = 2
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "'leetcode\\.nvim'" },
	group = md_group,
	callback = function()
		print("leetcode!")
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

vim.api.nvim_create_autocmd("BufEnter", {
	group = global_group,
	callback = function()
		vim.cmd("syntax match TODO /@TODO/ containedin=@comment,@comment.documentation")
	end,
})

local pasteImg = require("cmds.paste-img")
vim.api.nvim_create_user_command("PasteImgClipboardObsidian", pasteImg, { nargs = "?" })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "copilot-*",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.statuscolumn = " "
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "codecompanion",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.statuscolumn = " "
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "oil",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.statuscolumn = " "
	end,
})

vim.filetype.add({
	extension = {
		pcss = "scss",
	},
	filename = {},
	pattern = {},
})

local config = require("config")
local opt = vim.opt

for key, value in pairs(config) do
	opt[key] = value
end
opt.iskeyword:append("-")
vim.cmd("set noswapfile")

vim.keymap.set("n", "<leader>pd", function()
	local bufinfos = vim.fn.getbufinfo({ buflisted = true })
	vim.tbl_map(function(bufinfo)
		if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
			-- vim.api.nvim_buf_delete(bufinfo.bufnr, { force = false, unload = false })
			vim.cmd("bd " .. tostring(bufinfo.bufnr))
		end
	end, bufinfos)
end, { silent = true, desc = "Wipeout all buffers not shown in a window" })

local global_group = vim.api.nvim_create_augroup("Global Highlights", { clear = true })
local md_group = vim.api.nvim_create_augroup("MD Highlights", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	group = md_group,
	callback = function()
		vim.cmd("syntax match MDDone /@DONE/")
		vim.cmd("syntax match MDReminder /@REMINDER/")
		vim.cmd("syntax match MDDate /@\\d\\{2}\\.\\d\\{2}\\.\\d\\{4}/")
		vim.cmd("syntax match MDDate /@\\d\\{2}\\.\\d\\{2}\\.\\d\\{2}/")
		vim.cmd("syntax match MDDate /@\\d\\{2}\\.\\d\\{4}/ ")
		vim.cmd("syntax match Bold /\\*\\*.*\\*\\*/")

		local o = vim.opt
		o.conceallevel = 2
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

local split_by_space = function(s)
	local words = {}
	for word in s:gmatch("[%a%-_]+") do
		table.insert(words, word)
	end
	return words
end

local utils = require("utils")
local pngpastePath = "~/dev/utils/dotfiles/pngpaste.sh"
vim.api.nvim_create_user_command("PasteImgClipboard", function(args)
	local words = split_by_space(args["args"] or "")
	local dir = words[2] or "~/dev/documents/assets/imgs"

	local now = os.date("%d.%m.%Y")
	local filename = words[1] or now

	local dest = dir .. "/" .. filename
	vim.cmd("!" .. pngpastePath .. " " .. dest)
	utils.insert("![" .. dest .. "](" .. dest .. ".png)", true)
end, { nargs = "?" })

vim.api.nvim_create_user_command("PasteImgClipboardObsidian", function(args)
	local words = split_by_space(args["args"] or "")
	local dir = words[2] or "~/dev/documents/assets/imgs"

	local now = os.date("%d.%m.%Y")
	local filename = words[1] or now

	local dest = dir .. "/" .. filename
	vim.cmd("!" .. pngpastePath .. " " .. dest)
	utils.insert(" ![[" .. filename .. ".png]]", true)
end, { nargs = "?" })

-- https://neovim.io/doc/user/lua.html#vim.filetype.add%28%29
vim.filetype.add({
	extension = {
		pcss = "scss",
	},
	filename = {},
	pattern = {},
})

vim.treesitter.language.register("markdown", "codecompanion")

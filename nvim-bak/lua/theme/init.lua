-- Cloned from https://github.com/jesseleite/nvim-noirbuddy/blob/master/lua/noirbuddy/init.lua

local M = {}

function M.load()
	vim.cmd("hi clear")

	vim.o.background = "dark"
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.g.colors_name = "minimal_fedu"

	require("theme.colors")
	require("theme.highlights")
end

return M

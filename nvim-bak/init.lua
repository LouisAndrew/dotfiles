vim.g.mapleader = " "

if vim.g.neovide then
	-- vim.o.guifont = "CommitMonoxx,nonicons:h18:w2"
	vim.o.linespace = 16
	vim.g.neovide_padding_top = 6
	vim.g.neovide_padding_bottom = 6
	vim.g.neovide_padding_right = 6
	vim.g.neovide_padding_left = 6
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	-- vim.g.neovide_floating_corner_radius = 4
	vim.g.neovide_text_gamma = 0.8
	vim.g.neovide_text_contrast = 0.1
end

require("set")

-- set system clipboard
vim.opt.clipboard = "unnamedplus"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "plugins" } })
require("keymaps")

vim.keymap.set("n", "<M-k>", "<C-w>+")

vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

vim.g.ENABLE_AUTOFORMAT = "true"

local opt = vim.opt
local config = require("opts")
for key, value in pairs(config) do
	opt[key] = value
end

vim.cmd("colorscheme minimal_fedu")

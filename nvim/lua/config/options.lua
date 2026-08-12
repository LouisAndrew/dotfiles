-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
vim.opt.statuscolumn = [[%!v:lua.require("statuscol").statusCol()]]
vim.opt.listchars = {
  tab = "  ",
  trail = "-",
  nbsp = "+",
}
vim.opt.exrc = true
vim.g.lazyvim_eslint_auto_format = true

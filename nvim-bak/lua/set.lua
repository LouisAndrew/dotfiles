require("cmds")
local opt = vim.opt

opt.iskeyword:append("-")
vim.cmd("set noswapfile")

vim.treesitter.language.register("markdown", "codecompanion")

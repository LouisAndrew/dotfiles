return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
  },
  {
    "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("zed_minimal")
    end,
  },
}

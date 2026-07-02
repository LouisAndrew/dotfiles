local signs = {
  add = { text = "│" },
  change = { text = "│" },
  delete = { text = "│" },
  topdelete = { text = "‾" },
  changedelete = { text = "~" },
  untracked = { text = "┆" },
}

return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "esmuellert/codediff.nvim", -- optional
      "m00qek/baleia.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = signs,
      signs_staged = signs,
    },
  },
}

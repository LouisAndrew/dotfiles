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
      {
        "esmuellert/codediff.nvim",
        opts = {
          keymaps = {
            view = {
              next_hunk = "]h",
              prev_hunk = "[h",
              open_in_prev_tab = "g<leader>",
              stage_hunk = "<leader>ghs",
              unstage_hunk = "<leader>ghu",
              discard_hunk = "<leader>ghr",
            },
            explorer = {
              select = "<CR>",
            },
          },
        },
      }, -- optional
      "m00qek/baleia.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
      { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "Show CodeDiff UI" },
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

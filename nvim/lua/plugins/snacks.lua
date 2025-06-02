return {
  "folke/snacks.nvim",
  opts = {
    indent = {
      enabled = false,
    },
    animate = {
      enabled = false,
    },
    scroll = {
      enabled = false,
    },
    picker = {
      win = {
        input = {
          keys = {
            ["<c-j>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-l>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["<c-r>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<c-g>"] = { "toggle_ignored", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}

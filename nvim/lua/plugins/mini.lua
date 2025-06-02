return {
  {
    "echasnovski/mini.files",
    keys = {
      { "_", "<cmd>:lua MiniFiles.open()<cr>" },
      { "-", "<cmd>:lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>" },
    },
    opts = {
      mappings = {
        synchronize = "S",
        go_in_plus = "<CR>",
      },
    },
  },
}

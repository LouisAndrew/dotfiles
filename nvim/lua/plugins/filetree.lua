return {
  {
    "nvim-mini/mini.files",
    keys = {
      { "_", "<cmd>:lua MiniFiles.open()<cr>" },
      {
        "-",
        function()
          if MiniFiles.get_explorer_state() then
            MiniFiles.close()
          else
            MiniFiles.open(vim.api.nvim_buf_get_name(0))
          end
        end,
      },
    },
    opts = {
      mappings = {
        close = "q",
        go_in_plus = "<CR>",
        synchronize = "<c-s>",
      },
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      options = {
        use_as_default_explorer = true,
      },
    },
  },
}

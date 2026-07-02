return {
  {
    "nvim-mini/mini.files",
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      options = {
        use_as_default_explorer = true,
      },
    },
    keys = {
      {
        "-",
        function()
          local path = vim.api.nvim_buf_get_name(0)
          require("mini.files").open(path ~= "" and path or vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
    },
  },
}

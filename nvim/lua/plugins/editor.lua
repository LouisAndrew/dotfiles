return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      table.insert(opts.spec, {
        "<C-b>",
        group = "buffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      })
    end,
  },
}

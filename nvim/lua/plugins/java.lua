return {
  {
    "mfussenegger/nvim-dap",
    config = function() end,
  },
  {
    "nvim-java/nvim-java",
    config = function()
      require("java").setup()
      vim.lsp.enable("jdtls")
    end,
  },
}

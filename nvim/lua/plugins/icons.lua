return {
  { "nvim-mini/mini.icons", enabled = false },
  {
    "ya2s/nvim-nonicons",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    init = function()
      require("nvim-nonicons").setup({})
    end,
  },
}

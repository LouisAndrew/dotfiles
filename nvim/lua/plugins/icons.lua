return {
  { "nvim-mini/mini.icons", enabled = false },
  {
    "ya2s/nvim-nonicons",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    init = function()
      local devicons = require("nvim-web-devicons")
      devicons.setup({
        color_icons = false,
      })

      require("nvim-nonicons").setup({})
    end,
  },
}

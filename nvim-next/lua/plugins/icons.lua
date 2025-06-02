return {
  {
    "yamatsum/nvim-nonicons",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    priority = 999,
    config = function()
      local devicons = require("nvim-web-devicons")
      devicons.setup({
        color_icons = false,
      })
      require("nvim-nonicons").setup({})
      devicons.set_icon_by_filetype({
        js = "Js",
        ts = "Ts",
      })
    end,
  },
}

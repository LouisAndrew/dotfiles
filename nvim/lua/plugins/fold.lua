local config = require("theme.minimal_fedu.config")

return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  event = "BufEnter",
  config = function()
    require("ufo").setup({
      close_fold_kinds_for_ft = {
        default = { "imports", "comment" },
        tsplayground = {},
      },
      preview = {
        win_config = {
          border = config.winborder,
          winblend = config.winblend,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
        },
      },
      provider_selector = function(_, ft)
        if ft == "tsplayground" then
          return { "indent" }
        end

        return { "treesitter", "indent" }
      end,
    })

    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeFoldsWith)

    vim.keymap.set("n", "z2", function()
      require("ufo").closeFoldsWith(1)
    end)

    vim.keymap.set("n", "z3", function()
      require("ufo").closeFoldsWith(2)
    end)

    vim.keymap.set("n", "zn", function()
      require("ufo").closeFoldsWith(1)
    end)

    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
  end,
  desc = "Folds",
}

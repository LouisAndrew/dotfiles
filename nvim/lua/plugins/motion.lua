return {
  {
    "folke/flash.nvim",
    opts = {
      labels = "asdfhjkl",
      modes = {
        search = {
          enabled = false,
        },
      },
    },
    keys = {
      { "s", false, mode = { "n", "x", "o" } },
      { "S", false, mode = { "n", "x", "o" } },
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "F",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "R",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "r",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "<c-s>",
        mode = "c",
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "sa",
        delete = "sd",
        highlight = "sh",
        replace = "sr",
      },
      keys = function(_, keys)
        -- Needs to be manually added due to custom impl from lazyvim
        -- https://www.lazyvim.org/extras/coding/mini-surround
        local opts = LazyVim.opts("mini.surround")
        local mappings = {
          { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "x" } },
          { opts.mappings.delete, desc = "Delete Surrounding" },
          { opts.mappings.find, desc = "Find Right Surrounding" },
          { opts.mappings.find_left, desc = "Find Left Surrounding" },
          { opts.mappings.highlight, desc = "Highlight Surrounding" },
          { opts.mappings.replace, desc = "Replace Surrounding" },
          { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
        }
        mappings = vim.tbl_filter(function(m)
          return m[1] and #m[1] > 0
        end, mappings)
        return vim.list_extend(mappings, keys)
      end,
    },
  },
}

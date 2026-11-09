return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = function(_, opts)
      if vim.env.HERDR_PANE_ID or vim.env.HC_TERMINAL_ID then
        opts.multiplexer_integration = false
      end
    end,
  },
  {
    "paulbkim-dev/vim-herdr-navigation",
    lazy = false,
    config = function(plugin)
      -- LazyVim loads its navigation maps after eager plugins.
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimKeymaps",
        once = true,
        callback = function()
          dofile(plugin.dir .. "/editor/nvim.lua")
        end,
      })
    end,
  },
}

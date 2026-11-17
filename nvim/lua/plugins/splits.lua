return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = {
    -- The Herdr app is not a smart-splits backend, so cross into its next pane by hand.
    at_edge = function(ctx)
      if vim.env.HC_TERMINAL_ID then
        vim.system({ "herdr-app", "do", "pane.go", "--direction", ctx.direction })
      else
        ctx.wrap()
      end
    end,
  },
}

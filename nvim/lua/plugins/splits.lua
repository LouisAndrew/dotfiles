return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = {
    -- The Herdr app and Rex are not smart-splits backends, so cross into their next pane by hand.
    at_edge = function(ctx)
      if vim.env.HC_TERMINAL_ID then
        vim.system({ "herdr-app", "do", "pane.go", "--direction", ctx.direction })
      elseif vim.env.REX_BLOCK then
        vim.system({ "rex", "focus", ctx.direction })
      else
        ctx.wrap()
      end
    end,
  },
}

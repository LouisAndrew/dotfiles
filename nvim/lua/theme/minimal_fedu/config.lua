local colors = require("theme.minimal_fedu.palette")

local M = {
  winborder = "single",
  winblend = 0,
  popup = {
    normal = { nil, colors.background },
    border = { colors.bg_accent, colors.background },
  },
}

return M

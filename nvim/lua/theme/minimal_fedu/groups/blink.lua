local colors = require("theme.minimal_fedu.palette")

return {
  prefix = "BlinkCmp",
  { "Menu", "NormalFloat", link = true },
  { "MenuBorder", "FloatBorder", link = true },
  { "Doc", "NormalFloat", link = true },
  { "DocBorder", "FloatBorder", link = true },
  { "DocSeparator", colors.palette.grey[9] },
}

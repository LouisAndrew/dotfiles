local colors = require("theme.minimal_fedu.palette")

local ufo = {
  prefix = "UfoFold",
  { "VirtualText", "Comment", link = true },
  { "PeekNormal", nil, colors.bg_shade },
}

local flash = {
  prefix = "Flash",
  { "Match", colors.palette.grey[5] },
  { "Current", colors.palette.grey[6] },
  { "Label", colors.palette.indigo[2], colors.palette.indigo[4] },
}

local outline = {
  prefix = "Outline",
  { "Current", colors.white },
  { "Guides", colors.palette.grey[6] },
}

return require("theme.minimal_fedu.merge_config")({ flash, ufo, outline })

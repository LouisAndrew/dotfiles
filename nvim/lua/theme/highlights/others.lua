local colors = require("minimal_fedu")

local mini_hipatterns = {
	prefix = "MiniHiPatterns",
	{ "Todo", colors.misc.remove_fg },
	{ "MdDate", colors.palette.magenta[2] },
	{ "MdDone", colors.misc.add_fg },
	{ "MDStuff", colors.palette.blue[2] },
}

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

local bqf = {
	{ "BqfPreviewFloat", "NormalFloat", link = true },
	{ "QuickFixLine", colors.palette.grey[1] },
	{ "Delimiter", colors.bg_shade },
}

local utils = {
	{ "TelescopeBorder", "FloatBorder", link = true },
}

return require("theme.config").mergeHlConfig({ flash, ufo, mini_hipatterns, bqf, utils })

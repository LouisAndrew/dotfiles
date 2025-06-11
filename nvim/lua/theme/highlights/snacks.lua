local colors = require("minimal_fedu")

local input = {
	prefix = "SnacksInput",
	{ "Normal", colors.white, colors.bg_shade },
	{ "Title", colors.palette.grey[5] },
}

local picker = {
	prefix = "SnacksPicker",
	{ "", nil, colors.background },
	{ "Border", colors.background },
	{ "Dir", colors.palette.grey[7] },
	{ "File", colors.palette.grey[4] },
	{ "Match", colors.white },
	{ "Row", colors.palette.grey[5] },
	{ "Col", colors.palette.grey[5] },
}

local rest = {
	prefix = "Snacks",
	{ "StatusColumnMark", colors.palette.grey[7] },
}

return require("theme.config").mergeHlConfig({ input, picker, rest })

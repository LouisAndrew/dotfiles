local colors = require("minimal_fedu")

local M = {
	{ "FlashMatch", colors.palette.grey[6] },
	{ "FlashCurrent", colors.palette.grey[6] },
	{ "FlashLabel", colors.palette.grey[2], nil },

	{ "UfoFoldVirtualText", colors.palette.grey[7] },
	{ "UfoFoldPeekNormal", nil, colors.bg_shade },
}

return M

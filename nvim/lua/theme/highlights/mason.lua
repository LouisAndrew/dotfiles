local colors = require("minimal_fedu")

local M = {
	{ "MasonHeader", colors.white, colors.palette.grey[10] },
	{ "MasonHeaderSecondary", colors.white },
	{ "MasonHighlight", colors.primary },
	{ "MasonHighlightBlock", colors.primary },
	{ "MasonHighlightBlockBold", colors.white, colors.palette.grey[10] },
	{ "MasonHighlightSecondary", colors.primary },
	{ "MasonHighlightBlockSecondary", colors.primary },
	{ "MasonHighlightBlockBoldSecondary", colors.white, colors.palette.grey[10] },
	{ "MasonMuted", colors.palette.grey[6] },
	{ "MasonMutedBlock", colors.palette.grey[6] },
	{ "MasonMutedBlockBold", colors.palette.grey[6] },
	{ "MasonError", colors.misc.remove_fg },
}

return M

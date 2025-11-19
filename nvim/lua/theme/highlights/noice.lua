local colors = require("minimal_fedu")

local M = {
	prefix = "Noice",
	{ "CmdlinePrompt", colors.white },
	{ "CmdlinePopup", nil, colors.bg_shade },
	{ "CmdlinePopupBorder", colors.debug, colors.background },
	{ "CmdlineIcon", colors.palette.grey[4], bold = true },
	{ "CmdlineIconSearch", colors.palette.grey[3], bold = true },
	{ "CmdlinePopupTitle", colors.palette.grey[5] },
	{ "Cursor", colors.palette.grey[3], colors.palette.grey[10] },
	{ "VirtualText", colors.palette.grey[8] },
	{ "Popup", "NormalFloat", link = true },
	{ "CmdlineSearch", colors.palette.grey[3], colors.background },
	{ "CmdlineSearchBorder", colors.background, colors.yellow_fg },
	{ "Cmdline", colors.white, colors.background },
	{ "CmdlineScript", colors.white },
	{ "CmdlineScriptBorder", colors.debug, colors.background },
	{ "InputNormal", colors.white, colors.bg_shade },
	{ "ConfirmBorder", "FloatBorder", link = true },
}

return M

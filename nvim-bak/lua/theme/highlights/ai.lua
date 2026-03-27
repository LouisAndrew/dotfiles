local colors = require("minimal_fedu")

local avante = {
	prefix = "Avante",
	{ "SidebarNormal", nil, colors.background },
	{ "SidebarWinHorizontalSeparator", nil, colors.background },
	{ "SidebarWinSeparator", colors.bg_accent, colors.background },
	{ "InlineHint", colors.palette.grey[8] },
	{ "Title", colors.palette.grey[5], colors.background },
	{ "ReversedTitle", colors.background, colors.background },
	{ "SubTitle", "AvanteTitle", link = true },
	{ "ReversedSubtitle", "AvanteReversedTitle", link = true },
	{ "ThirdTitle", "AvanteTitle", link = true },
	{ "ReversedThirdTitle", "AvanteReversedTitle", link = true },
}

return require("theme.config").mergeHlConfig({ avante })

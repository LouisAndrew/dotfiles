local colors = require("minimal_fedu")

local avante = {
	prefix = "Avante",
	{ "SidebarNormal", nil, colors.background },
	{ "SidebarWinHorizontalSeparator", nil, colors.background },
	{ "SidebarWinSeparator", colors.bg_accent, colors.background },
	{ "InlineHint", colors.palette.grey[8] },
}

return require("theme.config").mergeHlConfig({ avante })

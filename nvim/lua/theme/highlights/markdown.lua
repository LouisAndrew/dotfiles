local colors = require("minimal_fedu")

local markdown = {
	prefix = "RenderMarkdown",
	{ "CodeInline", nil, colors.background },
	{ "Code", nil, colors.bg_accent_light },
	{ "Quote", colors.palette.indigo[2] },
	{ "Update", colors.palette.magenta[2] },
	{ "TableHead", colors.bg_accent },
	{ "TableRow", colors.bg_accent },
	{ "WikiLink", colors.palette.navy[1], nil },
	{ "Link", colors.palette.navy[1], nil },
}

local obsidian = {
	prefix = "Obsidian",
	{ "RefText", colors.cyan, nil },
	{ "HighlightText", colors.debug, nil },
	{ "ExtLinkIcon", colors.navy, nil },
	{ "Tag", colors.palette.indigo[2] },
}

return require("theme.config").mergeHlConfig({ markdown, obsidian })

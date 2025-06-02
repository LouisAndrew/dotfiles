local colors = require("minimal_fedu")

return {
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

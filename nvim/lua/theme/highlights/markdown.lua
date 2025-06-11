local colors = require("minimal_fedu")

local markdown = {
	prefix = "RenderMarkdown",
	{ "CodeInline", nil, colors.background },
	{ "Code", nil, colors.bg_shade },
	{ "Quote", colors.palette.indigo[2] },
	{ "Update", colors.palette.magenta[2] },
	{ "TableHead", colors.bg_accent },
	{ "TableRow", colors.bg_accent },
	{ "WikiLink", colors.palette.grey[6], nil },
	{ "Link", colors.palette.grey[6], nil },
}

local ts = {
	{ "@lsp.type.enumMember.markdown", colors.palette.indigo[2] },
	{ "@markup.link.label.markdown_inline", colors.palette.grey[6] },
	{ "@lsp.type.class.markdown", "@markup.link.label.markdown_inline", link = true },
	{ "@markup.link.url.markdown_inline", colors.foreground },
}

return require("theme.config").mergeHlConfig({ markdown, ts })

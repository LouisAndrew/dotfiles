local colors = require("minimal_fedu")

local kind = {
	prefix = "BlinkCmpKind",
	{ "File", colors.palette.grey[3] },
	{ "Module", colors.palette.grey[3] },
	{ "Namespace", colors.palette.grey[3] },
	{ "Package", colors.palette.grey[3] },
	{ "Class", colors.palette.red[2] },
	{ "Method", colors.misc.bool },
	{ "Property", colors.palette.cyan[1] },
	{ "Field", colors.palette.cyan[1] },
	{ "Constructor", colors.palette.grey[3] },
	{ "Enum", colors.palette.green[2] },
	{ "Interface", colors.palette.navy[1] },
	{ "Function", colors.misc.bool },
	{ "Variable", colors.palette.navy[1] },
	{ "Constant", colors.palette.grey[3] },
	{ "String", colors.palette.green[2] },
	{ "Number", colors.palette.grey[3] },
	{ "Boolean", colors.palette.grey[3] },
	{ "Array", colors.palette.grey[3] },
	{ "Object", colors.palette.grey[3] },
	{ "Key", colors.palette.green[2] },
	{ "Null", colors.palette.grey[3] },
	{ "EnumMember", colors.palette.grey[3] },
	{ "Struct", colors.palette.grey[3] },
	{ "Event", colors.palette.grey[3] },
	{ "Operator", colors.palette.grey[3] },
	{ "TypeParameter", colors.palette.grey[3] },
	{ "Unit", colors.palette.cyan[2] },
	{ "Text", colors.palette.grey[3] },
	{ "Snippet", colors.palette.grey[3] },
	{ "Keyword", colors.palette.grey[3] },
}

local menu = {
	prefix = "BlinkCmp",
	{ "Menu", "NormalFloat", link = true },
	{ "MenuBorder", "FloatBorder", link = true },
	{ "Doc", "NormalFloat", link = true },
	{ "DocBorder", "FloatBorder", link = true },
	{ "DocSeparator", colors.palette.grey[9] },
}

return require("theme.config").mergeHlConfig({ menu, kind })

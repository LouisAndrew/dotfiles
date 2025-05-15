local colors = require("minimal_fedu")

---@type _HlConfig
local M = {
	prefix = "Navic",
	fg = colors.palette.grey[6],
	{ "IconsFile" },
	{ "IconsModule" },
	{ "IconsNamespace" },
	{ "IconsPackage" },
	{ "IconsClass" },
	{ "IconsMethod" },
	{ "IconsProperty" },
	{ "IconsField" },
	{ "IconsConstructor" },
	{ "IconsEnum" },
	{ "IconsInterface" },
	{ "IconsFunction" },
	{ "IconsVariable" },
	{ "IconsConstant" },
	{ "IconsString" },
	{ "IconsNumber" },
	{ "IconsBoolean" },
	{ "IconsArray" },
	{ "IconsObject" },
	{ "IconsKey" },
	{ "IconsNull" },
	{ "IconsEnumMember" },
	{ "IconsStruct" },
	{ "IconsEvent" },
	{ "IconsOperator" },
	{ "IconsTypeParameter" },
	{ "Text" },
	{ "Separator" },
}

return M

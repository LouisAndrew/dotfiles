local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node

return {
	s("fn", fmt("function {}() {} end", { i(1), i(2) })),
}

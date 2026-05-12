local ls = require("luasnip")
local utils = require("utils")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node
local i = ls.insert_node

return {
	s("imd", fmt("import {{ {} }} from '{}';", { i(2), i(1) })),
	s("imw", fmt("import {} from '{}';", { i(2), i(1) })),

	s(
		"imp",
		fmt('import {justincase}{actual} from "{from}"', {
			actual = f(utils.extract_component_name, { 1 }),
			from = i(1),
			justincase = i(2),
		})
	),

	s("clg", fmt("console.log({});", { i(1, "message") })),
	s('clw', fmt('console.log("wis {}");', { i(1) })),
	s(
		"fn",
		fmt(
			[[
{}function {}({}) {{
	{}
}}
]],
			{
				i(1),
				i(2, "functionName"),
				i(3, "params"),
				i(0),
			}
		)
	),
	s(
		"afn",
		fmt(
			[[
{}const {} = ({}) => {{
	{}
}}
]],
			{
				i(1),
				i(2, "functionName"),
				i(3, "params"),
				i(0),
			}
		)
	),
}

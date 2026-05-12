local ls = require("luasnip")
local utils = require("utils")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local t = ls.text_node

local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node

return {
	s(
		"imd",
		fmt("import {{ {actual} }} from '{from}';", {
			from = i(1),
			actual = i(2),
		})
	),

	s("imw", fmt("import {module} from '{from}';", { from = i(1), module = i(2) })),

	s(
		"imp",
		fmt('import {justincase}{actual} from "{from}"', {
			actual = f(utils.extract_component_name, { 1 }),
			from = i(1),
			justincase = i(2),
		})
	),

	s("clg", fmt("console.log({});", { i(1, "message") })),
	s('clw', fmt('console.log("wis {}");', { i(1, "message") })),

	s(
		"ds",
		fmt("const {destructure} = {variable};", {
			variable = i(1),
			destructure = c(2, {
				sn(nil, fmt("{{ {} }}", { i(1) })),
				sn(nil, fmt("[{}]", { i(1) })),
			}),
		})
	),

	s(
		"arf",
		fmt("{async}({ar}) => {body}", {
			async = c(3, {
				sn(nil, fmt("{}", { i(1) })),
				sn(nil, fmt("async {}", { i(1) })),
			}),
			ar = c(2, {
				sn(nil, fmt("{}", { i(1) })),
				sn(nil, fmt("{{ {} }}", { i(1) })),
			}),
			body = c(1, {
				sn(nil, fmt("{{ {} }}", i(1))),
				sn(nil, fmt("{}", i(1))),
			}),
		})
	),
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

	s(
		"fl",
		fmt("for {loop} {{ {body} }}", {
			loop = c(1, {
				sn(nil, fmt("(let i = 0; i < {length}; i++)", { length = i(1) })),
				sn(nil, fmt("(let i = {length}; i >= 0; i--)", { length = i(1) })),
				sn(nil, fmt("(const {variable} of {iterable})", { variable = i(1), iterable = i(2) })),
			}),
			body = i(2),
		})
	),

	---- Specfile snippets

	s(
		"it",
		fmt('it("{spec}", () => {{ {body} }})', {
			spec = i(1),
			body = i(2),
		})
	),

	s("exp", fmt("expect({}).{}", { i(1), i(2) })),
}

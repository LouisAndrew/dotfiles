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
	-- ls.snippet({ trig = "vts" }, {t('<script setup lang="ts">$0</script>') }),
	s(
		"imd",
		fmt('import {actual} from "{from}"', {
			from = i(1),
			actual = c(2, {
				sn(nil, fmt("{{ {} }}", { i(1) })),
				i(1),
			}),
		})
	),

	s(
		"imp",
		fmt('import {justincase}{actual} from "{from}"', {
			actual = f(utils.extract_component_name, { 1 }),
			from = i(1),
			justincase = i(2),
		})
	),

	s("clg", fmt("console.log({})", { i(1) })),

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
		fmt("{declaration}({ar}) {{ {body} }}", {
			declaration = c(1, {
				sn(nil, fmt("function {}", { i(1) })),
				sn(nil, fmt("async function {}", { i(1) })),
			}),
			ar = i(2),
			body = i(3),
		})
	),

	s(
		"fl",
		fmt("for {loop} {{ {body} }}", {
			loop = c(1, {
				sn(nil, fmt("(let i = 0; i < {length}; i++)", { length = i(1) })),
				sn(nil, fmt("(let i = {length}; i >= 0; i--)", { length = i(1) })),
				sn(nil, fmt("({variable} of {iterable})", { variable = i(1), iterable = i(2) })),
			}),
			body = i(2),
		})
	),
}

local ls = require("luasnip")
local utils = require("utils")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node
local t = ls.text_node

return {
	s("vts", fmt('<script setup lang="ts">{}</script>', { i(1) })),
	s("tem", fmt("<template>{}</template>", { i(1) })),
	s("pcs", fmt('<style scoped lang="postcss">{}</style>', { i(1) })),

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

	-- Vues
	s(
		"rf",
		fmt("const {var} = ref{ref}", {
			var = i(1),
			ref = sn(
				2,
				fmt("{generic}({default})", {
					generic = c(1, {
						t(""),
						sn(nil, fmt("<{}>", { i(1) })),
					}),
					default = i(2),
				})
			),
		})
	),

	s(
		"rc",
		fmt("const {var} = reactive{reactive}", {
			var = i(1),
			reactive = sn(
				2,
				fmt("{generic}({default})", {
					generic = c(1, {
						t(""),
						sn(nil, fmt("<{}>", { i(1) })),
					}),
					default = i(2),
				})
			),
		})
	),

	s(
		"pr",
		fmt("const {v} = defineProps<{p}>()", {
			p = i(1),
			v = c(2, {
				sn(nil, fmt("{{ {} }}", { i(1) })),
				t("props"),
			}),
		})
	),

	s(
		"em",
		fmt("const emit = defineEmits<{{ {p} }}>()", {
			p = i(1),
		})
	),

	s(
		"cm",
		fmt("const {var} = computed{ref}", {
			var = i(1),
			ref = sn(
				2,
				fmt("{generic}(() => {default})", {
					generic = c(1, {
						t(""),
						sn(nil, fmt("<{}>", { i(1) })),
					}),
					default = i(2),
				})
			),
		})
	),

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
		fmt("{declaration}({ar}){retType} {{ {body} }}", {
			declaration = c(1, {
				sn(nil, fmt("function {}", { i(1) })),
				sn(nil, fmt("async function {}", { i(1) })),
			}),
			ar = i(2),
			retType = i(3),
			body = i(4),
		})
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
	s("vm", fmt('v-model="{}"', i(1))),
	s("db", fmt("{{{{ {} }}}}", i(1))),
}

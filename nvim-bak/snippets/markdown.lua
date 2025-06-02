local ls = require("luasnip")
local utils = require("utils")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node

return {
	-- ls.snippet({ trig = "vts" }, {t('<script setup lang="ts">$0</script>') }),
	s("lk", fmt("[{}]({})", { i(2), i(1) })),
	s("lp", fmt("[{}]({})", { i(1), f(utils.paste) })),
	s("td", t("@" .. os.date("%Y-%m-%d"))),

	s("h2", t("## ")),
	s("h3", t("### ")),
	s("h4", t("#### ")),

	s(
		"shs",
		fmt(
			[[
```sh
{c}
```
    ]],
			{ c = i(1) }
		)
	),
	s(
		"ss",
		fmt(
			[[
```{lang}
{c}
```
    ]],
			{ lang = i(1), c = i(2) }
		)
	),

	s(
		"tss",
		fmt(
			[[
```ts
{c}
```
    ]],
			{ c = i(1) }
		)
	),

	s(
		"yls",
		fmt(
			[[
```yaml
{c}
```
    ]],
			{ c = i(1) }
		)
	),
}

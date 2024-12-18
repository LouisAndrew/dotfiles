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
	s("lkp", fmt("[{}]({})", { i(1), f(utils.paste) })),
	s("td", t("@" .. os.date("%Y-%m-%d"))),

	s("h2", t("## $0")),
	s("h3", t("### $0")),
	s("h4", t("#### $0")),
}

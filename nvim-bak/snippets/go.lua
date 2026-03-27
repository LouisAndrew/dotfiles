local ls = require("luasnip")
local sn = ls.snippet_node
local s = ls.snippet


local fmt = require("luasnip.extras.fmt").fmt
local f = true
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node


return {
    s(
        "fn",
        fmt("func {fnName}({ar}){retType} {{ {body} }}", {
            fnName = i(1),
            ar = i(2),
            retType = i(3),
            body = i(4),
        })
    ),

    s(
        "gto",
        fmt(
            [[
  func Test{functionName}(t *testing.T) {{
    got := {got}
    want := {want}

    if {test} {{
      t.Errorf("got %v want %v", got, want)
    }}
  }}
  ]],
            {
                functionName = i(1),
                got = i(2),
                want = i(3),
                test = c(4, {
                    t("got != want"),
                    t("!reflect.DeepEqual(got, want)"),
                }),
            }
        )
    ),
    s(
        "tr",
        fmt(
            [[
  t.Run("{name}", func (t *testing.T) {{
    got := {got}
    want := {want}

    if {test} {{
      t.Errorf("got %v want %v", got, want)
    }}
  }})
  ]],
            {
                name = i(1),
                got = i(2),
                want = i(3),
                test = c(4, {
                    t("got != want"),
                    t("!reflect.DeepEqual(got, want)"),
                }),
            }
        )
    ),
    s(
        "gtr",
        fmt(
            [[
  func Test{functionName}(t *testing.T) {{
    t.Run("{name}", func (t *testing.T) {{
      got := {got}
      want := {want}

      if {test} {{
        t.Errorf("got %v want %v", got, want)
      }}
    }})
  }}
  ]],
            {
                functionName = i(1),
                name = i(2),
                got = i(3),
                want = i(4),
                test = c(5, {
                    t("got != want"),
                    t("!reflect.DeepEqual(got, want)"),
                }),
            }
        )
    ),

    s(
        "fl",
        fmt("for {loop} {{ {body} }}", {
            loop = c(1, {
                sn(nil, fmt("i := 0; i < {len}; i++", { len = i(1) })),
                sn(nil, fmt("i := {len}; i >= 0; i--", { len = i(1) })),
                sn(nil, fmt("_, {i} := range {j}", { i = i(1), j = i(2) })),
            }),
            body = i(2),
        })
    ),

    s(
        "ini",
        fmt(
            [[
  if {var} != nil {{
    {body}
  }}
  ]],
            {
                var = c(1, {
                    sn(nil, t("err")),
                    sn(nil, i(1)),
                }),
                body = i(2),
            }
        )
    ),
}

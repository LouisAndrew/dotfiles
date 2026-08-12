vim.g.colors_name = "zed_minimal"

package.loaded["lush_theme.zed_minimal"] = nil

local lush = require("lush")
lush(require("lush_theme.zed_minimal"))

local links = {
  ["@attribute"] = "Function",
  ["@boolean"] = "Boolean",
  ["@character"] = "Character",
  ["@comment"] = "Comment",
  ["@constant"] = "Constant",
  ["@constant.builtin"] = "Number",
  ["@constant.builtin.javascript"] = "Nullish",
  ["@constant.builtin.typescript"] = "Nullish",
  ["@constant.builtin.tsx"] = "Nullish",
  ["@constructor"] = "Structure",
  ["@diff.plus"] = "Added",
  ["@diff.minus"] = "Removed",
  ["@diff.delta"] = "Changed",
  ["@function"] = "Function",
  ["@function.builtin"] = "Function",
  ["@function.call"] = "Function",
  ["@keyword"] = "Keyword",
  ["@keyword.function"] = "Keyword",
  ["@keyword.import"] = "Include",
  ["@keyword.operator"] = "Keyword",
  ["@label"] = "Label",
  ["@module"] = "Identifier",
  ["@number"] = "Number",
  ["@operator"] = "Operator",
  ["@property"] = "Identifier",
  ["@punctuation"] = "Delimiter",
  ["@punctuation.bracket"] = "Delimiter",
  ["@punctuation.delimiter"] = "Delimiter",
  ["@string"] = "String",
  ["@string.escape"] = "SpecialChar",
  ["@tag"] = "Tag",
  ["@tag.attribute"] = "Type",
  ["@tag.delimiter"] = "Delimiter",
  ["@type"] = "Type",
  ["@type.builtin"] = "Type",
  ["@variable"] = "Identifier",
  ["@variable.builtin"] = "Special",
  ["@variable.builtin.javascript"] = "Nullish",
  ["@variable.builtin.typescript"] = "Nullish",
  ["@variable.builtin.tsx"] = "Nullish",
  ["@variable.parameter"] = "Identifier",
  ["@variable.member"] = "Identifier",
}

for capture, target in pairs(links) do
  vim.api.nvim_set_hl(0, capture, { link = target })
end

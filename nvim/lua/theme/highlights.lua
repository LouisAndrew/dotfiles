local minimal_fedu = require("colors")
local Group = require("colorbuddy").Group
local colors = require("colorbuddy").colors
local styles = require("colorbuddy").styles

Group.new("Normal", colors.mfed_4, colors.nb_background)
Group.new("Search", colors.mfed_2, colors.mfed_8)
Group.new("IncSearch", colors.mfed_2, colors.mfed_8)
Group.new("CurSearch", colors.mfed_9, colors.yellow_fg)

Group.new("Visual", nil, colors.visual)
Group.new("SignColumn", nil, colors.nb_background)
Group.new("LineNr", colors.mfed_7, nil)
Group.new("EndOfBuffer", colors.mfed_8, nil)

Group.new("Comment", colors.mfed_7)
Group.new("Constant", colors.mfed_3)
Group.new("Character", colors.mfed_5)
Group.new("Identifier", colors.mfed_0)
Group.new("Statement", colors.mfed_1)
Group.new("PreProc", colors.primary)
Group.new("Type", colors.secondary)
Group.new("Special", colors.mfed_5)
Group.new("Error", colors.primary)
Group.new("Function", colors.mfed_0)
Group.new("ColorColumn", nil, colors.mfed_8)
Group.new("Conceal", colors.mfed_7)
Group.new("CursorColumn", nil, colors.mfed_9)
Group.new("CursorLine", nil, colors.mfed_9)
Group.new("CursorLineNr", colors.mfed_6, colors.noir_9)

Group.new("Cursor", nil, colors.yellow_fg)
Group.new("iCursor", nil, colors.add_fg)
Group.new("vCursor", nil, colors.indigo_fg)
Group.new("oCursor", nil, colors.remove_fg)
Group.new("rCursor", nil, colors.yellow_fg)

Group.new("Directory", colors.mfed_3)

Group.new("DiffAdd", colors.primary, colors.mfed_8)
Group.new("DiffChange", colors.mfed_0, colors.noir_8)
Group.new("DiffDelete", colors.secondary, colors.mfed_8)
Group.new("DiffText", colors.mfed_0, colors.noir_7)
Group.new("ErrorMsg", colors.mfed_1, colors.primary)

Group.new("Folded", colors.dimmed_white, colors.mfed_bg_accent)

Group.new("UfoFoldVirtualText", colors.mfed_bg_accent_light:light():light():light():light())
Group.new("UfoFoldPeekNormal", nil, colors.bg_shade)
--
Group.new("FoldColumn", colors.mfed_bg_accent_light:light():light():light(), nil)
Group.new("MatchParen", nil, colors.mfed_7)

Group.new("MoreMsg", nil, colors.mfed_6)
Group.new("NonText", colors.mfed_8, nil)
Group.new("PmenuThumb", nil, colors.bg_shade:light())
Group.new("PmenuSbar", nil, colors.nb_background)
Group.new("Question", colors.mfed_1, colors.noir_8)
Group.new("SpecialKey", colors.mfed_6, nil)
Group.new("SpellBad", colors.primary)
Group.new("SpellCap", colors.mfed_0)
Group.new("SpellLocal", colors.mfed_5)
Group.new("SpellRare", colors.primary)
Group.new("StatusLine", colors.mfed_5, colors.noir_8)
Group.new("TabLine", colors.mfed_3, colors.noir_8)
Group.new("TabLineFill", nil, colors.mfed_8)
Group.new("TabLineSel", colors.mfed_2, nil)
Group.new("Title", colors.mfed_3)
Group.new("VisualNOS", colors.primary, colors.mfed_8)
Group.new("WarningMsg", colors.primary)
Group.new("WildMenu", colors.mfed_5, colors.noir_8)

Group.new("FloatTitle", colors.mfed_0)
Group.new("NormalFloat", colors.mfed_4, colors.bg_shade)

-- Treesitter Syntax Highlighting
-- See :help treesitter-highlight-groups
Group.new("@boolean", colors.primary)
Group.new("@character", colors.secondary)
Group.new("@character.special", colors.mfed_2)
Group.new("@conditional", colors.mfed_2)
Group.new("@constant", colors.mfed_3)
Group.new("@constant.builtin", colors.mfed_2)
Group.new("@constant.macro", colors.primary)
Group.new("@constructor", colors.mfed_1)
Group.new("@debug", colors.mfed_2)
Group.new("@define", colors.mfed_2)
Group.new("@exception", colors.mfed_cyan)
Group.new("@field", colors.mfed_2)
Group.new("@float", colors.mfed_2)
Group.new("@function", colors.mfed_0)
Group.new("@function.builtin", colors.mfed_2)
Group.new("@function.call", colors.mfed_2)
Group.new("@function.macro", colors.primary)
Group.new("@include", colors.mfed_6)
Group.new("@keyword", colors.mfed_5)
Group.new("@keyword.function", colors.mfed_5)
Group.new("@keyword.operator", colors.mfed_6)
Group.new("@keyword.return", colors.mfed_0)
Group.new("@label", colors.mfed_2)
Group.new("@macro", colors.primary)
Group.new("@method", colors.mfed_1)
Group.new("@method.call", colors.mfed_1)
Group.new("@namespace", colors.mfed_2)
Group.new("@none", colors.mfed_3)
Group.new("@number", colors.primary)
Group.new("@operator", colors.mfed_6)
Group.new("@parameter", colors.mfed_2)
Group.new("@preproc", colors.mfed_2)
Group.new("@property", colors.mfed_2)
Group.new("@punctuation", colors.mfed_2)
Group.new("@punctuation.bracket", colors.mfed_6)
Group.new("@punctuation.delimiter", colors.mfed_6)
Group.new("@punctuation.special", colors.primary)
Group.new("@repeat", colors.mfed_navy)
Group.new("@storageclass", colors.mfed_2)
Group.new("@string", colors.primary)
Group.new("@string.escape", colors.mfed_2)
Group.new("@string.special", colors.mfed_2)
Group.new("@structure", colors.mfed_2)
Group.new("@tag", colors.mfed_6)
Group.new("@tag.attribute", colors.mfed_4)
Group.new("@tag.delimiter", colors.mfed_3)
Group.new("@text.literal", colors.mfed_1)
Group.new("@text.reference", colors.secondary)
Group.new("@text.title", colors.mfed_2, nil, styles.bold)
Group.new("@text.underline", colors.mfed_2)
Group.new("@text.uri", colors.mfed_2)
Group.new("@type", colors.mfed_2)
Group.new("@identifier", colors.mfed_0)
Group.new("@type.builtin", colors.mfed_6)
Group.new("@type.definition", colors.mfed_2)
Group.new("@variable", colors.secondary)
Group.new("@variable.builtin", colors.mfed_2)
Group.new("@lsp.type.function", colors.mfed_0)
Group.new("@lsp.type.macro", colors.primary)
Group.new("@lsp.type.method", colors.mfed_2)
Group.new("@markup.heading", colors.mfed_2, nil, styles.bold)
Group.new("@markup.italic", nil, nil, styles.italic)
Group.new("@markup.list", colors.mfed_2, nil)
Group.new("@markup.raw", colors.mfed_num, nil)
Group.new("@keyword.conditional.ternary", colors.mfed_6, nil)
Group.new("@punctuation.special", colors.mfed_3)
Group.new("@comment", colors.mfed_7)

-- Semantic Highlighting
Group.new("DiagnosticError", colors.diagnostic_error)
Group.new("DiagnosticWarn", colors.diagnostic_warning)
Group.new("DiagnosticInfo", colors.diagnostic_info)
Group.new("DiagnosticHint", colors.diagnostic_hint)
Group.new("DiagnosticSignError", colors.diagnostic_error, colors.remove)
Group.new("DiagnosticSignWarn", colors.diagnostic_warning)
Group.new("DiagnosticSignInfo", colors.diagnostic_info)
Group.new("DiagnosticSignHint", colors.diagnostic_hint)

Group.new("DiffAdd", nil, colors.add)
Group.new("DiffDelete", nil, colors.remove)
Group.new("DiffChange", nil, colors.change)
Group.new("DiffText", nil, colors.change)

-- LSP
Group.new("Identifier", colors.mfed_0)
Group.new("@keyword.return", colors.mfed_cyan)
Group.new("@type.qualifier", colors.mfed_navy) -- rust `mut`
Group.new("@include", colors.mfed_cyan)
Group.new("@punctuation.delimiter", colors.mfed_dim)
Group.new("@tag", colors.white)
Group.new("@type.builtin", colors.mfed_dim)
Group.new("@boolean", colors.mfed_bool)
Group.new("@number", colors.mfed_num)
Group.new("@function.macro", colors.mfed_cyan)
Group.new("@macro", colors.mfed_cyan)
Group.new("@constant.macro", colors.mfed_cyan)
Group.new("@conditional", colors.mfed_cyan)
Group.new("@lsp.type.macro", colors.mfed_cyan)
Group.new("@text.strong", nil, nil, styles.bold)
Group.new("@text.emphasis", nil, nil, styles.italic)
Group.new("LspSignatureActiveParameter", colors.mfed_cyan)

-- Editor stuff
Group.new("CursorLineNr", colors.white, nil)
Group.new("TabLine", colors.dimmed_white, nil)
Group.new("TabLineFill", nil, nil)
Group.new("EndOfBuffer", colors.background, nil)
Group.new("ErrorMsg", colors.dimmed_red)
Group.new("Pmenu", colors.mfed_2, colors.bg_shade)

Group.new("PmenuSel", colors.white, colors.mfed_bg_accent)
Group.new("StatusLine", colors.mfed_bg_accent, colors.mfed_bg_accent)
Group.new("FloatBorder", colors.bg_shade)
Group.new("DiagnosticShowBorder", colors.bg_shade)

-- code action
Group.new("ActionPreviewTitle", colors.primary)
Group.new("CodeActionText", colors.secondary)
Group.new("CodeActionConceal", colors.add)

-- finder
Group.new("FinderSelection", colors.primary)
Group.new("FinderFileName", colors.mfed_5)
Group.new("FinderIcon", colors.secondary)
Group.new("FinderType", colors.secondary)
Group.new("FinderCount", colors.secondary, colors.nb_background)

-- finder spinner
Group.new("FinderSpinnerTitle", colors.primary)
Group.new("FinderSpinner", colors.primary)
Group.new("FinderVirtText", colors.mfed_7)
-- hover
Group.new("HoverNormal", colors.primary, colors.nb_background)
-- rename
Group.new("RenameNormal", colors.secondary, colors.bg_shade)
-- diagnostic
Group.new("DiagnosticSource", colors.primary)
Group.new("DiagnosticPos", colors.mfed_7)
Group.new("DiagnosticWord", colors.secondary)
-- call heirarchy
Group.new("CallHierarchyIcon", colors.primary)
Group.new("CallHierarchyTitle", colors.secondary)
-- outline
Group.new("OutlineIndent", colors.mfed_7)
-- terminal
Group.new("TerminalNormal", colors.secondary, colors.nb_background)

-- Signs
Group.new("diffAdded", colors.add_fg)
Group.new("diffRemoved", colors.remove_fg)
Group.new("diffChanged", colors.change)
-- gitsigns
Group.new("GitSignsChange", colors.blue:light():light():light())
Group.new("GitSignsAdd", colors.add:light():light():light())
Group.new("GitSignsDelete", colors.remove:light():light():light())

Group.new("diffFile", colors.primary)
Group.new("diffNewFile", colors.primary)
Group.new("diffLine", colors.primary)

-- DiffView
Group.new("DiffAdd", nil, colors.add)
Group.new("DiffDelete", nil, colors.remove)
Group.new("DiffChange", nil, colors.change)
Group.new("DiffText", nil, colors.change)

Group.new("BufferInactive", nil, colors.mfed_bg_accent)

Group.new("DiagnosticError", colors.diagnostic_error, nil)
Group.new("DiagnosticWarn", colors.yellow_fg, nil)

-- LuaLine
Group.new("LuaLineDiffChange", colors.blue_fg, nil)
Group.new("LuaLineDiffAdd", colors.add_fg, nil)
Group.new("LuaLineDiffDelete", colors.remove_fg, nil)

-- Telescope
-- Group.new("TelescopeTitle", colors.white, colors.bg_shade, styles.bold)
Group.new("TelescopeTitle", colors.dimmed_white:dark(), nil, styles.bold)
Group.new("TelescopeNormal", nil, colors.bg_shade)
Group.new("TelescopeBorder", colors.mfed_bg_accent_light, colors.bg_shade)
Group.new("TelescopeMatching", colors.mfed_0)
Group.new("TelescopePromptCounter", colors.mfed_dim:dark(), nil)
Group.new("TelescopeResultsNormal", colors.mfed_dim, colors.bg_shade)
Group.new("TelescopeSelection", colors.white, colors.mfed_bg_accent)

-- Saga
Group.new("TitleString", colors.secondary)
Group.new("TitleSymbol", colors.primary)
Group.new("TitleIcon", colors.primary)
Group.new("SagaNormal", nil, colors.bg_shade)
Group.new("SagaExpand", colors.remove_fg)
Group.new("SagaCollapse", colors.remove_fg)
Group.new("SagaBeacon", colors.primary)

-- Obsidian
Group.new("ObsidianRefText", colors.mfed_cyan)
Group.new("ObsidianHighlightText", colors.debug)
Group.new("ObsidianExtLinkIcon", colors.mfed_navy)
Group.new("ObsTag", colors.magenta_fg:light(), nil, styles.bold)

-- CMP
Group.new("CmpItemAbbrDeprecated", colors.mfed_dim, nil)
Group.new("CmpItemAbbrMatch", colors.mfed_cyan)
Group.new("CmpItemAbbrMatchFuzzy", colors.mfed_cyan)

Group.new("CmpItemKindVariable", colors.mfed_navy)
Group.new("CmpItemKindInterface", colors.mfed_navy)
Group.new("CmpItemKindText", colors.mfed_navy)

Group.new("CmpItemKindFunction", colors.mfed_bool)
Group.new("CmpItemKindMethod", colors.mfed_bool)
Group.new("CmpItemKindClass", colors.remove_fg)

Group.new("CmpItemKindKeyword", colors.mfed_cyan)
Group.new("CmpItemKindProperty", colors.mfed_cyan)
Group.new("CmpItemKindUnit", colors.mfed_cyan)

-- Mason
Group.new("MasonHeader", colors.secondary, colors.mfed_9)
Group.new("MasonHeaderSecondary", colors.secondary)
Group.new("MasonHighlight", colors.primary)
Group.new("MasonHighlightBlock", colors.primary)
Group.new("MasonHighlightBlockBold", colors.secondary, colors.mfed_9)
Group.new("MasonHighlightSecondary", colors.primary)
Group.new("MasonHighlightBlockSecondary", colors.primary)
Group.new("MasonHighlightBlockBoldSecondary", colors.secondary, colors.mfed_9)
Group.new("MasonMuted", colors.mfed_5)
Group.new("MasonMutedBlock", colors.mfed_5)
Group.new("MasonMutedBlockBold", colors.mfed_5)
Group.new("MasonError", colors.remove_fg)

-- Nvim tree
Group.new("NvimTreeRootFolder", colors.mfed_6)
Group.new("NvimTreeFolderIcon", colors.primary)
Group.new("NvimTreeIndentMarker", colors.mfed_6)
Group.new("NvimTreeExecFile", colors.mfed_6)
Group.new("NvimTreeSpecialFile", colors.mfed_2, nil)

Group.new("MDDone", colors.add_fg, colors.add, styles.bold)
Group.new("MDReminder", colors.yellow_fg, colors.yellow, styles.bold)
-- Group.new("MDDate", colors.indigo_fg, colors.indigo, styles.bold)
Group.new("MDDate", colors.indigo_fg, nil, styles.bold)
Group.new("TODO", colors.remove_fg, colors.remove, styles.bold)
Group.new("Bold", nil, nil, styles.bold)
Group.new("Todo", colors.remove_fg, colors.remove, styles.bold)
Group.new("@text.todo", colors.remove_fg, colors.remove, styles.bold)
Group.new("Debug", colors.debug, colors.debug)

Group.new("nvimtreefoldericon", colors.mfed_dim)
Group.new("sagaborder", colors.bg_shade)
Group.new("cmpmenu", nil, colors.bg_shade)

Group.new("cmpborder", colors.bg_shade, nil)
Group.new("dapbreakpoint", colors.remove_fg)

Group.new("paletteborder", colors.bg_shade)
Group.new("wildermatch", colors.yellow_fg)
Group.new("IlluminatedWordText", nil, colors.mfed_9, nil)
Group.new("IlluminatedWordRead", nil, colors.mfed_9, nil)
Group.new("IlluminatedWordWrite", nil, colors.mfed_9, nil)

Group.new("InclineNormal", colors.mfed_2, nil)
Group.new("InclineNormalNC", colors.mfed_6, nil)
Group.new("RainbowDelimiterCyan", colors.mfed_cyan)
Group.new("TreesitterContext", nil, colors.mfed_bg_accent)

local level_hl_raw = {
	{ "Error", minimal_fedu.diagnostic_error },
	{ "Warn", minimal_fedu.diagnostic_warning },
	{ "Hint", minimal_fedu.diagnostic_hint },
	{ "Info", minimal_fedu.diagnostic_info },
}

local level = {
	{ "Error", colors.diagnostic_error },
	{ "Warn", colors.diagnostic_warning },
	{ "Hint", colors.diagnostic_hint },
	{ "Info", colors.diagnostic_info },
}

for _, l in ipairs(level_hl_raw) do
	local hi_group = "DiagnosticUnderline" .. l[1]
	local hi_color = l[2]

	vim.cmd("hi! " .. hi_group .. " gui=underline guisp=" .. hi_color)
end

--- @class HlConfig
--- @field fg string
--- @field bg (string|nil)
--- @field guicg? string

--- @param group string
--- @param M HlConfig
--- @return nil
local set_hl = function(group, M)
	local bg = M.bg or nil
	local guicg = M.guicg or nil

	Group.new(group, M.fg, bg, guicg)
end

local md_config = {
	{ "RenderMarkdownCodeInline", nil, colors.background },
	{ "RenderMarkdownCode", nil, colors.bg_shade },
	{ "RenderMarkdownLink", colors.mfed_navy, nil },
}

local dap_config = {
	{ "DapUIScope", colors.mfed_navy },
	{ "DapUIModifiedValue", colors.mfed_navy },
	{ "DapUIDecoration", colors.mfed_navy },
	{ "DapUIStoppedThread", colors.mfed_navy },
	{ "DapUILineNumber", colors.mfed_navy },
	{ "DapUIFloatBorder", colors.mfed_navy },
	{ "DapUIBreakpointsPath", colors.mfed_navy },
	{ "DapUIStepOver", colors.mfed_navy },
	{ "DapUIStepInto", colors.mfed_navy },
	{ "DapUIStepBack", colors.mfed_navy },
	{ "DapUIStepOut", colors.mfed_navy },
	{ "DapUIType", colors.mfed_cyan },
	{ "DapUISource", colors.mfed_cyan },
	{ "DapUILineNumber", colors.mfed_dim },
	{ "DapUIBreakpointsInfo", colors.mfed_cyan },
	{ "DapUIBreakpointsCurrentLine", colors.mfed_cyan },
	{ "DapUIWatchesValue", colors.mfed_cyan },
	{ "DapUIWatchesEmpty", colors.diagnostic_error },
	{ "DapUIWatchesError", colors.diagnostic_error },
}

local notify_config = {
	{ "NotifyERRORBorder", colors.mfed_bg_accent },
	{ "NotifyWARNBorder", colors.mfed_bg_accent },
	{ "NotifyINFOBorder", colors.mfed_bg_accent },
	{ "NotifyDEBUGBorder", colors.mfed_bg_accent },
	{ "NotifyTRACEBorder", colors.mfed_bg_accent },
}

local noice_config = {
	{ "NoiceCmdlinePrompt", colors.nb_background },
	{ "NoiceCmdlinePopup", nil, colors.indigo_fg },
	{ "NoiceCmdlinePopupBorder", colors.bg_shade, colors.nb_background },
	{ "NoiceCmdlineIcon", colors.mfed_3, nil, styles.bold },
	{ "NoiceCmdlineIconSearch", colors.mfed_2, nil, styles.bold },
	{ "NoiceCmdlinePopupTitle", colors.dimmed_white:light() },
	{ "NoiceCmdlinePopupBorderSearch", colors.bg_shade:dark(), colors.nb_background },
	{ "NoiceCursor", colors.mfed_2, colors.noir_9 },
	{ "NoiceVirtualText", colors.yellow_fg },
	{ "NoicePopupBorder", colors.bg_shade, colors.nb_background },
	{ "NoicePopup", nil, colors.bg_shade },
	{ "NoiceCmdlineSearch", colors.mfed_2, colors.bg_shade },
	{ "NoiceCmdlineSearchBorder", colors.nb_background, colors.yellow_fg },
	{ "NoiceCmdline", colors.white, colors.bg_shade },
	{ "NoiceCmdlineScript", colors.white, colors.mfed_navy:dark():dark():dark():dark() },
	{ "NoiceCmdlineScriptBorder", colors.mfed_navy:dark():dark():dark():dark(), colors.nb_background },
	{ "NoiceInputNormal", colors.white, colors.bg_shade },
	{ "NoiceHoverNormal", nil, colors.bg_shade },
}

local navic_config = {
	{ "NavicIconsFile", colors.mfed_2 },
	{ "NavicIconsModule", colors.mfed_2 },
	{ "NavicIconsNamespace", colors.mfed_2 },
	{ "NavicIconsPackage", colors.mfed_2 },
	{ "NavicIconsClass", colors.remove_fg },
	{ "NavicIconsMethod", colors.mfed_bool },
	{ "NavicIconsProperty", colors.mfed_cyan },
	{ "NavicIconsField", colors.mfed_cyan },
	{ "NavicIconsConstructor", colors.mfed_2 },
	{ "NavicIconsEnum", colors.add_fg },
	{ "NavicIconsInterface", colors.mfed_navy },
	{ "NavicIconsFunction", colors.mfed_bool },
	{ "NavicIconsVariable", colors.mfed_navy },
	{ "NavicIconsConstant", colors.mfed_2 },
	{ "NavicIconsString", colors.add_fg },
	{ "NavicIconsNumber", colors.mfed_2 },
	{ "NavicIconsBoolean", colors.mfed_2 },
	{ "NavicIconsArray", colors.mfed_2 },
	{ "NavicIconsObject", colors.mfed_2 },
	{ "NavicIconsKey", colors.add_fg },
	{ "NavicIconsNull", colors.mfed_2 },
	{ "NavicIconsEnumMember", colors.mfed_2 },
	{ "NavicIconsStruct", colors.mfed_2 },
	{ "NavicIconsEvent", colors.mfed_2 },
	{ "NavicIconsOperator", colors.mfed_2 },
	{ "NavicIconsTypeParameter", colors.mfed_2 },
	{ "NavicText", colors.mfed_4 },
	{ "NavicSeparator", colors.mfed_2 },
}

local gpt_config = {
	{
		"ChatGPTNormal",
		colors.dimmed_white,
		colors.bg_shade,
	},
}

local diagflow_config = {
	{ "DiagnosticFloatingError", colors.diagnostic_error, colors.remove },
	{ "DiagnosticFloatingWarn", colors.diagnostic_warning, colors.yellow:dark() },
	{ "DiagnosticFloatingWarnLighter", colors.diagnostic_warning, colors.yellow },
	{ "DiagnosticFloatingInfo", colors.diagnostic_info, colors.bg_shade },
	{ "DiagnosticFloatingHint", colors.diagnostic_hint, colors.bg_shade },
}

local luasnip_config = {
	-- { "LuaSnipInsertActive", minimal_fedu.palette.blue_fg },
	-- { "LuaSnipChoiceActive", minimal_fedu.palette.indigo_fg },
}

for _, pair in pairs(luasnip_config) do
	local hi_group = pair[1]
	local hi_color = pair[2]
	vim.cmd("hi! " .. hi_group .. " gui=underline guisp=" .. hi_color)
end

for _, lvl in ipairs(level) do
	for _, group in ipairs({ "Icon", "Title" }) do
		local hl_group = "Notify" .. lvl[1] .. group
		local hl_color = lvl[2]

		notify_config[#notify_config + 1] = { hl_group, hl_color }
	end
end

local hl_group_configs = {
	dap_config,
	notify_config,
	noice_config,
	navic_config,
	gpt_config,
	diagflow_config,
	md_config,
}

for _, config in ipairs(hl_group_configs) do
	for _, l in ipairs(config) do
		local group = l[1]
		local fg = l[2]
		local bg = l[3] or nil
		local guicg = l[4] or nil

		set_hl(group, { fg = fg, bg = bg, guicg = guicg })
	end
end

Group.new("VertSplit", colors.debug, colors.debug)
Group.new("WinSeparator", colors.mfed_bg_accent)
Group.new("BqfPreviewFloat", nil, colors.bg_shade)
Group.new("QuickFixLine", colors.white, nil, styles.bold)

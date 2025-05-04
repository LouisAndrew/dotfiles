local minimal_fedu = require("minimal_fedu")
local Group = require("colorbuddy").Group
local colors = require("colorbuddy").colors
local styles = require("colorbuddy").styles

Group.new("Normal", colors.mfed_4, colors.nb_background)
Group.new("Search", colors.mfed_2, colors.mfed_8)
Group.new("IncSearch", colors.mfed_2, colors.mfed_8)
Group.new("CurSearch", colors.mfed_9, colors.indigo_fg)

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
Group.new("Special", colors.dimmed_white)
Group.new("Error", colors.primary)
Group.new("Function", colors.mfed_0)
Group.new("ColorColumn", nil, colors.mfed_8)
Group.new("Conceal", colors.mfed_7)
Group.new("CursorColumn", nil, colors.mfed_9)
Group.new("CursorLine", nil, colors.mfed_9)
Group.new("vCursorLine", colors.indigo_fg)
Group.new("RCursorLine", colors.yellow_fg)

Group.new("Cursor", colors.indigo_fg, colors.indigo_fg)
Group.new("iCursor", nil, colors.indigo_fg)
Group.new("vCursor", nil, colors.indigo_fg)
Group.new("oCursor", nil, colors.remove_fg)
Group.new("rCursor", nil, colors.yellow_fg)

Group.new("Directory", colors.mfed_3)

Group.new("DiffAdd", colors.primary, colors.mfed_8)
Group.new("DiffChange", colors.mfed_0, colors.noir_8)
Group.new("DiffDelete", colors.secondary, colors.mfed_8)
Group.new("DiffText", colors.mfed_0, colors.noir_7)
Group.new("ErrorMsg", colors.mfed_1, colors.primary)

Group.new("Folded", colors.noir_9, nil)

Group.new("UfoFoldVirtualText", colors.mfed_7)
Group.new("UfoFoldPeekNormal", nil, colors.bg_shade)
--
Group.new("FoldColumn", colors.mfed_8)
Group.new("MatchParen", nil, colors.mfed_7)

Group.new("MoreMsg", colors.mfed_6, nil) -- `confirm` normal
Group.new("NonText", colors.mfed_8, nil)
Group.new("PmenuThumb", nil, colors.mfed_bg_accent)
Group.new("PmenuSbar", nil, colors.nb_background)
Group.new("Question", colors.mfed_1, colors.noir_8)
Group.new("SpecialKey", colors.mfed_6, nil)
Group.new("SpellBad", colors.primary)
Group.new("SpellCap", colors.mfed_0)
Group.new("SpellLocal", colors.mfed_5)
Group.new("SpellRare", colors.primary)

Group.new("StatusLine", nil, colors.mfed_9)
Group.new("TabLine", colors.mfed_3, colors.noir_8)
Group.new("TabLineFill", nil, colors.mfed_8)
Group.new("TabLineSel", colors.mfed_2, nil)
Group.new("Title", colors.mfed_3)
Group.new("VisualNOS", colors.primary, colors.mfed_8)
Group.new("WarningMsg", colors.primary)
Group.new("WildMenu", colors.mfed_5, colors.noir_8)

Group.new("FloatTitle", colors.mfed_0)
Group.new("NormalFloat", nil, colors.nb_background)
Group.new("FloatBorder", colors.mfed_bg_accent, colors.nb_background)

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
Group.new("@punctuation.delimiter", colors.mfed_6)
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
Group.new("@attribute", colors.secondary)
Group.new("@variable.builtin", colors.mfed_2)
Group.new("@lsp.type.function", colors.mfed_0)
Group.new("@lsp.type.macro", colors.primary)
Group.new("@lsp.type.method", colors.mfed_2)
Group.new("@keyword.conditional.ternary", colors.mfed_6, nil)
Group.new("@punctuation.special", colors.mfed_7) -- incl. separator on border hover
Group.new("@punctuation.bracket", colors.mfed_6)
Group.new("@line-separator", colors.mfed_8) -- Custom TS query

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
Group.new("Pmenu", colors.mfed_2, colors.nb_background)

Group.new("PmenuSel", nil, colors.mfed_bg_accent)
Group.new("StatusLine", colors.mfed_bg_accent, colors.mfed_bg_accent)
Group.new("DiagnosticShowBorder", colors.nb_background)

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
Group.new("HoverNormal", colors.primary)
-- rename
Group.new("RenameNormal", colors.secondary, colors.nb_background)
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
Group.new("diffChanged", colors.blue_fg)
Group.new("GitSignsChange", colors.indigo_fg)

Group.new("GitSignsAdd", colors.add_fg)
Group.new("GitSignsDelete", colors.remove_fg)

Group.new("diffFile", colors.primary)
Group.new("diffNewFile", colors.primary)
Group.new("diffLine", colors.primary)
-- DiffView
Group.new("DiffAdd", nil, colors.add)
Group.new("DiffDelete", nil, colors.remove)
Group.new("DiffChange", nil, colors.change)
Group.new("DiffText", nil, colors.change)

-- Group.new("BufferInactive", nil, colors.mfed_bg_accent)

Group.new("DiagnosticError", colors.diagnostic_error, nil)
Group.new("DiagnosticWarn", colors.yellow_fg, nil)

-- LuaLine
Group.new("LuaLineDiffChange", colors.blue_fg, nil)
Group.new("LuaLineDiffAdd", colors.add_fg, nil)
Group.new("LuaLineDiffDelete", colors.remove_fg, nil)
Group.new("WinBar", nil, nil, nil)
Group.new("WinBarNC", nil, nil, nil)

-- Telescope
-- Group.new("TelescopeTitle", colors.white, colors.nb_background, styles.bold)
Group.new("TelescopeTitle", colors.dimmed_white:dark(), nil, styles.bold)
Group.new("TelescopeNormal", nil)
Group.new("TelescopeBorder", colors.bg_shade, nil)
Group.new("TelescopeMatching", colors.mfed_0)
Group.new("TelescopePromptCounter", colors.mfed_dim:dark(), nil)
Group.new("TelescopeResultsNormal", colors.mfed_dim)
Group.new("TelescopeSelection", colors.white, colors.mfed_bg_accent)
Group.new("EgrepifyFile", colors.mfed_2, nil)
Group.new("String", colors.primary)

-- Saga
Group.new("TitleString", colors.secondary)
Group.new("TitleSymbol", colors.primary)
Group.new("TitleIcon", colors.primary)
Group.new("SagaNormal", nil, colors.nb_background)
Group.new("SagaExpand", colors.remove_fg)
Group.new("SagaCollapse", colors.remove_fg)
Group.new("SagaBeacon", colors.primary)

-- Obsidian
Group.new("ObsidianRefText", colors.mfed_cyan)
Group.new("ObsidianHighlightText", colors.debug)
Group.new("ObsidianExtLinkIcon", colors.mfed_navy)

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

Group.new("CmpItemAbbrDeprecated", colors.mfed_dim, nil)
Group.new("CmpItemAbbrMatch", colors.mfed_cyan)
Group.new("CmpItemAbbrMatchFuzzy", colors.mfed_cyan)

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

Group.new("Bold", nil, nil, styles.bold)
Group.new("Debug", colors.debug, colors.debug)

Group.new("nvimtreefoldericon", colors.mfed_dim)
Group.new("sagaborder", colors.nb_background)
Group.new("cmpmenu", nil, colors.bg_shade)

Group.new("bg_shadeBorder", colors.black)

Group.new("cmpborder", colors.nb_background, nil)
Group.new("dapbreakpoint", colors.remove_fg)

Group.new("paletteborder", colors.nb_background)
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

local render_markdown = {
	prefix = "RenderMarkdown",
	{ "CodeInline", nil, colors.background },
	{ "Code", nil, colors.mfed_bg_accent_light },
	{ "Quote", colors.indigo_fg },
	{ "Update", colors.magenta_fg:light() },
	{ "TableHead", colors.mfed_bg_accent },
	{ "TableRow", colors.mfed_bg_accent },
	{ "WikiLink", colors.mfed_navy, nil },
	{ "Link", colors.mfed_navy, nil },
}

local md_config = {
	{ "InlineCode", nil, colors.nb_background },
	{ "@spell.markdown", colors.mfed_2 },
	{ "@markup", colors.dimmed_white },
	{ "@markup.link", colors.mfed_0 },
	{ "@markup.heading", colors.white, nil, styles.bold },
	{ "@markup.italic", nil, nil, styles.italic },
	{ "@markup.list", colors.mfed_2, nil },
	{ "@markup.raw", colors.mfed_bool:light() },
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

local snacks_config = {
	{ "SnacksInputBorder", colors.dimmed_white, colors.mfed_bg_accent },
	{ "SnacksInputNormal", colors.white, colors.mfed_bg_accent },
}

local snacks_picker_config = {
	prefix = "SnacksPicker",
	{ "", nil, colors.nb_background },
	{ "Border", colors.nb_background },
	{ "Dir", colors.mfed_6 },
	{ "File", colors.mfed_3 },
	{ "Match", colors.white },
	{ "Row", colors.dimmed_white },
	{ "Col", colors.dimmed_white },
	{ "Box", nil, colors.debug },
}

local snacks_indent = {
	prefix = "SnacksIndent",
	{ "", colors.mfed_9 },
	{ "Scope", colors.mfed_8 },
}

local noice_config = {
	prefix = "Noice",
	{ "CmdlinePrompt", colors.white },
	{ "CmdlinePopup", nil, colors.bg_shade },
	{ "CmdlinePopupBorder", colors.debug, colors.nb_background },
	{ "CmdlineIcon", colors.mfed_3, nil, styles.bold },
	{ "CmdlineIconSearch", colors.mfed_2, nil, styles.bold },
	{ "CmdlinePopupTitle", colors.dimmed_white:light() },
	{ "CmdlinePopupBorderSearch", colors.nb_background:dark(), colors.nb_background },
	{ "Cursor", colors.mfed_2, colors.noir_9 },
	{ "VirtualText", colors.indigo_fg_light },
	{ "PopupBorder", colors.nb_background, colors.nb_background },
	{ "Popup", nil, colors.nb_background },
	{ "CmdlineSearch", colors.mfed_2, colors.nb_background },
	{ "CmdlineSearchBorder", colors.nb_background, colors.yellow_fg },
	{ "Cmdline", colors.white, colors.nb_background },
	{ "CmdlineScript", colors.white, colors.mfed_navy:dark():dark():dark():dark() },
	{ "CmdlineScriptBorder", colors.mfed_navy:dark():dark():dark():dark(), colors.nb_background },
	{ "InputNormal", colors.white, colors.bg_shade },
	{ "HoverNormal", nil, colors.nb_background },
	{ "HoverBorder", colors.mfed_bg_accent },
	{ "ConfirmBorder", colors.mfed_bg_accent },
}

local cmp_config = {
	prefix = "BlinkCmpKind",
	{ "File", colors.mfed_2 },
	{ "Module", colors.mfed_2 },
	{ "Namespace", colors.mfed_2 },
	{ "Package", colors.mfed_2 },
	{ "Class", colors.remove_fg },
	{ "Method", colors.mfed_bool },
	{ "Property", colors.mfed_cyan },
	{ "Field", colors.mfed_cyan },
	{ "Constructor", colors.mfed_2 },
	{ "Enum", colors.add_fg },
	{ "Interface", colors.mfed_navy },
	{ "Function", colors.mfed_bool },
	{ "Variable", colors.mfed_navy },
	{ "Constant", colors.mfed_2 },
	{ "String", colors.add_fg },
	{ "Number", colors.mfed_2 },
	{ "Boolean", colors.mfed_2 },
	{ "Array", colors.mfed_2 },
	{ "Object", colors.mfed_2 },
	{ "Key", colors.add_fg },
	{ "Null", colors.mfed_2 },
	{ "EnumMember", colors.mfed_2 },
	{ "Struct", colors.mfed_2 },
	{ "Event", colors.mfed_2 },
	{ "Operator", colors.mfed_2 },
	{ "TypeParameter", colors.mfed_2 },
	{ "Unit", colors.mfed_cyan },
	{ "Text", colors.mfed_2 },
	{ "Snippet", colors.mfed_2 },
	{ "Keyword", colors.mfed_2 },
}

local navic_config = {
	prefix = "Navic",
	{ "IconsFile", colors.mfed_2 },
	{ "IconsModule", colors.mfed_2 },
	{ "IconsNamespace", colors.mfed_2 },
	{ "IconsPackage", colors.mfed_2 },
	{ "IconsClass", colors.remove_fg },
	{ "IconsMethod", colors.mfed_bool },
	{ "IconsProperty", colors.mfed_cyan },
	{ "IconsField", colors.mfed_cyan },
	{ "IconsConstructor", colors.mfed_2 },
	{ "IconsEnum", colors.add_fg },
	{ "IconsInterface", colors.mfed_navy },
	{ "IconsFunction", colors.mfed_bool },
	{ "IconsVariable", colors.mfed_navy },
	{ "IconsConstant", colors.mfed_2 },
	{ "IconsString", colors.add_fg },
	{ "IconsNumber", colors.mfed_2 },
	{ "IconsBoolean", colors.mfed_2 },
	{ "IconsArray", colors.mfed_2 },
	{ "IconsObject", colors.mfed_2 },
	{ "IconsKey", colors.add_fg },
	{ "IconsNull", colors.mfed_2 },
	{ "IconsEnumMember", colors.mfed_2 },
	{ "IconsStruct", colors.mfed_2 },
	{ "IconsEvent", colors.mfed_2 },
	{ "IconsOperator", colors.mfed_2 },
	{ "IconsTypeParameter", colors.mfed_2 },
	{ "Text", colors.mfed_4 },
	{ "Separator", colors.mfed_7 },
}

local gpt_config = {
	{
		"ChatGPTNormal",
		colors.dimmed_white,
		colors.nb_background,
	},
	{
		"CopilotChatSpinner",
		colors.white,
		nil,
	},
}

local diagnostic_config = {
	{ "DiagnosticFloatingError", colors.diagnostic_error, colors.nb_background },
	{ "DiagnosticFloatingWarn", colors.diagnostic_warning, colors.nb_background },
	{ "DiagnosticFloatingWarnLighter", colors.diagnostic_warning, colors.nb_background },
	{ "DiagnosticFloatingInfo", colors.diagnostic_info, colors.nb_background },
	{ "DiagnosticFloatingHint", colors.diagnostic_hint, colors.nb_background },
}

local blink_config = {
	prefix = "BlinkCmp",
	{ "Menu", nil, colors.nb_background },
	{ "MenuBorder", colors.mfed_bg_accent, nil },
	{ "Doc", nil, colors.background },
	{ "DocBorder", colors.mfed_bg_accent, nil },
	{ "DocSeparator", colors.mfed_8 },
}

local mini_hipatterns_config = {
	prefix = "MiniHiPatterns",
	{ "Todo", colors.remove_fg },
	{ "MdDate", colors.magenta_fg:light() },
	{ "MdDone", colors.add_fg },
	{ "MDStuff", colors.blue_fg },
}

local flash_config = {
	{ "FlashMatch", colors.indigo_fg },
	{ "FlashCurrent", colors.indigo_fg },
	{ "FlashLabel", colors.indigo_fg, colors.indigo },
}

local avante_config = {
	prefix = "Avante",
	{ "SidebarNormal", nil, colors.nb_background },
	{ "SidebarWinHorizontalSeparator", nil, colors.nb_background },
	{ "SidebarWinSeparator", colors.mfed_bg_accent, colors.nb_background },
	{ "InlineHint", colors.mfed_7 },
}

local mini_file_config = {
	prefix = "MiniFiles",
	{ "BorderModified", colors.indigo_fg },
	{ "Title", colors.mfed_6 },
	{ "TitleFocused", colors.mfed_6 },
}

local bqf_config = {
	{ "BqfPreviewFloat", nil, colors.nb_background },
	{ "QuickFixLine", colors.mfed_1 },
	{ "Delimiter", colors.nb_background },
}

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
	render_markdown,
	md_config,
	snacks_config,
	snacks_picker_config,
	cmp_config,
	flash_config,
	diagnostic_config,
	mini_hipatterns_config,
	avante_config,
	snacks_indent,
	blink_config,
	mini_file_config,
	bqf_config,
}

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

for _, config in ipairs(hl_group_configs) do
	local prefix = config.prefix or ""
	for _, l in ipairs(config) do
		local group = prefix .. l[1]
		local fg = l[2]
		local bg = l[3] or nil
		local guicg = l[4] or nil

		set_hl(group, { fg = fg, bg = bg, guicg = guicg })
	end
end

Group.new("WinSeparator", colors.mfed_bg_accent)

local minimal_fedu = require("minimal_fedu")
local Group = require("colorbuddy").Group
local colors = require("colorbuddy").colors
local styles = require("colorbuddy").styles

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
Group.new("DiagnosticShowBorder", colors.nb_background)

-- code action
Group.new("ActionPreviewTitle", colors.primary)
Group.new("CodeActionText", colors.secondary)
Group.new("CodeActionConceal", colors.add)

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
Group.new("TelescopeBorder", colors.background, nil)
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

-- -- Mason
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
	{ "Error", minimal_fedu.diagnostic.error },
	{ "Warn", minimal_fedu.diagnostic.warning },
	{ "Hint", minimal_fedu.diagnostic.hint },
	{ "Info", minimal_fedu.diagnostic.info },
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

local mini_hipatterns_config = {
	prefix = "MiniHiPatterns",
	{ "Todo", colors.remove_fg },
	{ "MdDate", colors.magenta_fg:light() },
	{ "MdDone", colors.add_fg },
	{ "MDStuff", colors.blue_fg },
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
	gpt_config,
	render_markdown,
	md_config,
	snacks_config,
	snacks_picker_config,
	diagnostic_config,
	mini_hipatterns_config,
	avante_config,
	snacks_indent,
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

local hl = require("utils").loaddir("lua/theme/highlights/*.lua", { "theme.highlights.init" })

---@alias GroupDefinition { [1]: string, [2]: string, [3]?: string, bold?: boolean, italic?: boolean, link?: boolean }
---@alias _HlConfig {prefix?: string, fg?: string} | GroupDefinition[]

---@param config _HlConfig
local function apply_hl(config)
	local prefix = config.prefix or ""
	local gl_fg = config.fg
	for _, l in ipairs(config) do
		local group = prefix .. l[1]
		local link = l.link or false

		if link then
			vim.api.nvim_set_hl(0, group, {
				link = l[2],
			})
		else
			local fg = l[2] or gl_fg or nil
			local bg = l[3] or nil

			vim.api.nvim_set_hl(0, group, {
				foreground = fg,
				background = bg,
				bold = l.bold,
				force = true,
			})
		end
	end
end

for _, config in pairs(hl) do
	apply_hl(config)
end

Group.new("WinSeparator", colors.mfed_bg_accent)
Group.new("Folded", nil, colors.nb_background)

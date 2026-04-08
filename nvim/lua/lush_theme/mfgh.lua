local lush = require("lush")
local hsl = lush.hsl
local theme_colors = require("theme.highlights.minimal_fedu_colors")

local p = theme_colors.palette
local g = theme_colors.groups

local function hex(color)
	if not color then
		return nil
	end

	if #color == 9 then
		return hsl(color:sub(1, 7))
	end

	return hsl(color)
end

---@diagnostic disable: undefined-global
return lush(function(injected)
	local sym = injected.sym

	return {
		Cursor({ fg = hex(p.bg_indigo), bg = hex(p.bg_indigo) }),
		ColorColumn({ bg = hex(p.border_subtle) }),
		Conceal({ fg = hex(p.fg_muted) }),
		CursorColumn({ bg = hex(p.border_subtle) }),
		CursorLine({ CursorColumn }),
		Directory({ fg = hex(p.label) }),

		Added({ fg = hex(g.diff_add.fg) }),
		Changed({ fg = hex(g.diff_change.fg) }),
		Removed({ fg = hex(g.diff_delete.fg) }),
		DiffAdd({ bg = hex(p.status_added) }),
		DiffChange({ bg = hex(p.surface_active) }),
		DiffText({ bg = hex(p.surface_search) }),
		DiffDelete({ bg = hex(p.border_error), fg = hex(p.status_deleted) }),

		EndOfBuffer({ fg = hex(p.bg_base) }),
		ErrorMsg({ fg = hex(p.bg_base), bg = hex(p.status_deleted) }),
		VertSplit({ EndOfBuffer }),
		WinSeparator({ EndOfBuffer }),
		Folded({ fg = hex(p.fg_disabled) }),
		FoldColumn({ Folded }),
		SignColumn({}),

		IncSearch({ fg = hex(p.bg_base), bg = hex(p.status_warning) }),
		CurSearch({ IncSearch }),
		LineNr({ Folded }),
		CursorLineNr({ fg = hex(p.fg_default) }),
		MatchParen({ fg = hex(p.fg_default), bg = hex(p.fg_disabled), gui = "bold" }),
		ModeMsg({ fg = hex(p.bg_base), bg = hex(p.function_name), gui = "bold" }),
		MsgArea({}),
		MsgSeparator({}),
		MoreMsg({ fg = hex(p.status_added) }),
		NonText({ fg = hex(p.fg_disabled) }),

		Normal({ bg = hex(p.bg_base), fg = hex(p.fg_editor) }),
		NormalFloat({ bg = hex(p.bg_base), fg = hex(p.fg_default) }),
		FloatBorder({ fg = hex(p.fg_disabled), bg = hex(p.bg_base) }),
		Pmenu({ bg = hex(p.bg_elevated), fg = hex(p.fg_default) }),
		PmenuSel({ bg = hex(p.surface_active), gui = "bold" }),
		PmenuSbar({}),
		PmenuThumb({ bg = hex(p.fg_muted) }),
		Question({ MoreMsg }),
		QuickFixLine({ bg = hex(p.status_warning) }),
		Search({ bg = hex(p.status_warning), fg = hex(p.bg_base) }),

		SpellBad({ fg = hex(p.status_deleted), gui = "underline" }),
		SpellCap({ fg = hex(p.label), gui = "underline" }),
		SpellLocal({ fg = hex(p.status_warning), gui = "underline" }),
		SpellRare({ fg = hex(p.status_success), gui = "underline" }),

		StatusLine({ bg = hex(p.fg_muted), gui = "bold" }),
		StatusLineNC({ Pmenu }),
		TabLine({ StatusLineNC }),
		TabLineFill({ TabLine }),
		TabLineSel({ StatusLine }),
		Title({ fg = hex(p.fg_white), gui = "bold" }),
		Visual({ bg = hex(p.surface_active) }),
		WarningMsg({ ErrorMsg }),
		WildMenu({ PmenuSel }),

		Comment({ fg = hex(p.comment), gui = "italic" }),
		Constant({ fg = hex(p.constant) }),
		String({ fg = hex(p.string) }),
		Character({ String, gui = "italic" }),
		Number({ fg = hex(p.number) }),
		Boolean({ fg = hex(p.boolean) }),
		Float({ fg = hex(p.number) }),
		Identifier({ fg = hex(p.fg_white) }),
		Function({ fg = hex(p.function_name) }),
		Statement({ fg = hex(p.keyword) }),
		Conditional({ fg = hex(p.keyword) }),
		Repeat({ fg = hex(p.keyword) }),
		Label({ fg = hex(p.label) }),
		Operator({ fg = hex(p.fg_light_gray) }),
		Keyword({ fg = hex(p.keyword) }),
		Exception({ fg = hex(p.keyword) }),
		PreProc({ fg = hex(p.fg_white) }),
		Include({ fg = hex(p.label) }),
		Define({ fg = hex(p.fg_bright) }),
		Macro({ fg = hex(p.hint_syntax) }),
		Type({ fg = hex(p.type) }),
		StorageClass({ fg = hex(p.keyword) }),
		Structure({ fg = hex(p.type) }),
		Typedef({ fg = hex(p.type) }),
		Special({ fg = hex(p.fg_white) }),
		Delimiter({ fg = hex(p.punctuation) }),
		SpecialComment({ fg = hex(p.comment_special) }),
		Underlined({ gui = "underline" }),
		Error({ bg = hex(p.status_deleted) }),
		Todo({ Comment, gui = "bold,italic" }),

		sym("@comment")({ Comment }),
		sym("@constant")({ Constant }),
		sym("@string")({ String }),
		sym("@string.escape")({ fg = hex(p.fg_light_gray) }),
		sym("@number")({ Number }),
		sym("@boolean")({ Boolean }),
		sym("@function")({ Function }),
		sym("@function.call")({ fg = hex(p.fg_default) }),
		sym("@function.builtin")({ fg = hex(p.function_name) }),
		sym("@parameter")({ fg = hex(p.fg_editor) }),
		sym("@method")({ Function }),
		sym("@field")({ fg = hex(p.fg_editor) }),
		sym("@property")({ fg = hex(p.property) }),
		sym("@constructor")({ fg = hex(p.constructor) }),
		sym("@conditional")({ Conditional }),
		sym("@repeat")({ Repeat }),
		sym("@label")({ Label }),
		sym("@operator")({ Operator }),
		sym("@keyword")({ Keyword }),
		sym("@keyword.return")({ fg = hex(p.keyword) }),
		sym("@variable")({ Identifier }),
		sym("@type")({ Type }),
		sym("@namespace")({ fg = hex(p.fg_light_gray) }),
		sym("@include")({ Include }),
		sym("@preproc")({ PreProc }),
		sym("@tag")({ fg = hex(p.tag) }),
		sym("@punctuation")({ fg = hex(p.fg_white) }),
		sym("@punctuation.delimiter")({ fg = hex(p.punctuation) }),
		sym("@punctuation.bracket")({ fg = hex(p.punctuation) }),

		-- JSON tuning to match minimal_fedu look
		sym("@property.json")({ fg = hex(p.fg_default) }),
		sym("@string.json")({ fg = hex(p.string) }),
		sym("@string.special.key")({ fg = hex(p.fg_default) }),
		sym("@string.special.key.json")({ fg = hex(p.fg_default) }),
		sym("@number.json")({ fg = hex(p.number) }),
		sym("@boolean.json")({ fg = hex(p.keyword) }),
		sym("@keyword.json")({ fg = hex(p.keyword) }),
		sym("@punctuation.bracket.json")({ fg = hex(p.function_name) }),
		sym("@punctuation.delimiter.json")({ fg = hex(p.punctuation) }),

		jsonKeyword({ fg = hex(p.fg_default) }),
		LspReferenceText({ bg = hex(p.document_highlight) }),
		LspReferenceRead({ bg = hex(p.document_highlight) }),
		LspReferenceWrite({ bg = hex(p.document_highlight) }),

		DiagnosticError({ fg = hex(g.diagnostic_error.fg) }),
		DiagnosticWarn({ fg = hex(g.diagnostic_warn.fg) }),
		DiagnosticInfo({ fg = hex(g.diagnostic_info.fg) }),
		DiagnosticHint({ fg = hex(g.diagnostic_hint.fg) }),
		DiagnosticUnderlineError({ gui = "underline", sp = hex(g.diagnostic_error.fg) }),
		DiagnosticUnderlineWarn({ gui = "underline", sp = hex(g.diagnostic_warn.fg) }),
		DiagnosticUnderlineInfo({ gui = "underline", sp = hex(g.diagnostic_info.fg) }),
		DiagnosticUnderlineHint({ gui = "underline", sp = hex(g.diagnostic_hint.fg) }),

		GitSignsAdd({ fg = hex(p.status_added) }),
		GitSignsChange({ fg = hex(p.status_warning) }),
		GitSignsDelete({ fg = hex(p.status_deleted) }),
	}
end)

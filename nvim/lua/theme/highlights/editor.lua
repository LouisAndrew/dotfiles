local colors = require("minimal_fedu")

local M = {
	{ "Normal", colors.palette.grey[5], colors.background },
	{ "Search", colors.palette.grey[6], colors.palette.grey[10] },
	{ "IncSearch", colors.palette.grey[3], colors.palette.grey[9] },
	{ "CurSearch", colors.palette.grey[10], colors.palette.indigo[2] },
	{ "Visual", nil, colors.misc.visual },
	{ "SignColumn", nil, colors.background },
	{ "LineNr", colors.palette.grey[8], nil },
	{ "EndOfBuffer", colors.palette.grey[10], nil },

	{ "Directory", colors.palette.grey[4] },
	{ "FoldColumn", colors.palette.grey[9] },
	{ "MatchParen", nil, colors.palette.grey[8] },
	{ "CursorLineNr", colors.white, nil },
	{ "TabLine", colors.palette.grey[5], nil },
	{ "TabLineFill", nil, nil },
	{ "EndOfBuffer", colors.background, nil },
	{ "ErrorMsg", colors.misc.remove_fg },
	{ "Pmenu", colors.palette.grey[3], nil },
	{ "PmenuSel", nil, colors.bg_shade },

	--- statuscol
	{ "ColorColumn", nil, colors.palette.grey[9] },
	{ "Conceal", colors.palette.grey[8] },
	{ "CursorColumn", nil, colors.palette.grey[10] },
	{ "vCursorLine", colors.palette.indigo[2] },
	{ "vSelected", colors.palette.grey[7] },
	{ "RCursorLine", colors.palette.yellow[2] },

	--- cursor
	{ "Cursor", nil, colors.palette.indigo[2] },
	{ "iCursor", nil, colors.palette.indigo[2] },
	{ "vCursor", nil, colors.palette.indigo[2] },
	{ "oCursor", nil, colors.misc.remove_fg },
	{ "rCursor", nil, colors.palette.yellow[2] },

	--- floats
	{ "FloatTitle", colors.palette.grey[5] },
	{ "NormalFloat", nil, colors.background },
	{ "FloatBorder", colors.bg_accent, colors.background },
	-- { "NormalFloat", nil, colors.bg_shade },
	-- { "FloatBorder", colors.bg_shade, colors.bg_shade },

	{ "MoreMsg", colors.palette.grey[6], nil }, -- `confirm` normal
	{ "NonText", colors.palette.grey[9], nil },
	{ "PmenuThumb", nil, colors.bg_accent },
	{ "PmenuSbar", nil, colors.background },
	{ "Question", colors.palette.grey[2], colors.palette.grey[9] },
	{ "SpecialKey", colors.palette.grey[7], nil },
	{ "SpellBad", colors.primary },
	{ "SpellCap", colors.palette.grey[1] },
	{ "SpellLocal", colors.palette.grey[6] },
	{ "SpellRare", colors.primary },

	{ "StatusLine", nil, colors.background },
	{ "TabLine", colors.palette.grey[4], colors.background },
	{ "TabLineFill", nil, colors.background },
	{ "TabLineSel", colors.white, nil },
	{ "Title", colors.palette.grey[4] },
	{ "VisualNOS", colors.primary, colors.palette.grey[9] },
	{ "WarningMsg", colors.primary },
	{ "WinSeparator", colors.bg_accent },
	{ "Folded", nil, colors.background },
	{ "WinBar", nil, colors.background },
	{ "WinBarNC", nil, colors.background, bold = true },
}

return M

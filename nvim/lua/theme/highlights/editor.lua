local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		Normal({ fg = H.hex(colors.palette.grey[5]), bg = H.hex(colors.background) }),
		Search({ fg = H.hex(colors.palette.grey[6]), bg = H.hex(colors.palette.grey[10]) }),
		IncSearch({ fg = H.hex(colors.palette.grey[3]), bg = H.hex(colors.palette.grey[9]) }),
		CurSearch({ fg = H.hex(colors.palette.grey[10]), bg = H.hex(colors.palette.indigo[2]) }),
		Visual({ bg = H.hex(colors.misc.visual) }),
		SignColumn({ bg = H.hex(colors.background) }),
		LineNr({ fg = H.hex(colors.palette.grey[8]) }),
		EndOfBuffer({ fg = H.hex(colors.background) }),

		Directory({ fg = H.hex(colors.palette.grey[4]) }),
		FoldColumn({ fg = H.hex(colors.palette.grey[9]) }),
		MatchParen({ bg = H.hex(colors.palette.grey[8]) }),
		CursorLineNr({ fg = H.hex(colors.white) }),
		TabLine({ fg = H.hex(colors.palette.grey[4]), bg = H.hex(colors.background) }),
		TabLineFill({ bg = H.hex(colors.background) }),
		ErrorMsg({ fg = H.hex(colors.misc.remove_fg) }),
		Pmenu({ fg = H.hex(colors.palette.grey[3]) }),
		PmenuSel({ bg = H.hex(colors.bg_shade) }),

		ColorColumn({ bg = H.hex(colors.palette.grey[9]) }),
		Conceal({ fg = H.hex(colors.palette.grey[8]) }),
		CursorColumn({ bg = H.hex(colors.palette.grey[10]) }),
		vCursorLine({ fg = H.hex(colors.palette.indigo[2]) }),
		vSelected({ fg = H.hex(colors.palette.grey[7]) }),
		RCursorLine({ fg = H.hex(colors.palette.yellow[2]) }),

		Cursor({ bg = H.hex(colors.palette.indigo[2]) }),
		iCursor({ bg = H.hex(colors.palette.indigo[2]) }),
		vCursor({ bg = H.hex(colors.palette.indigo[2]) }),
		oCursor({ bg = H.hex(colors.misc.remove_fg) }),
		rCursor({ bg = H.hex(colors.palette.yellow[2]) }),

		FloatTitle({ fg = H.hex(colors.palette.grey[5]) }),
		NormalFloat({ bg = H.hex(colors.background) }),
		FloatBorder({ fg = H.hex(colors.bg_accent), bg = H.hex(colors.background) }),

		MoreMsg({ fg = H.hex(colors.palette.grey[6]) }),
		NonText({ fg = H.hex(colors.palette.grey[9]) }),
		PmenuThumb({ bg = H.hex(colors.bg_accent) }),
		PmenuSbar({ bg = H.hex(colors.background) }),
		Question({ fg = H.hex(colors.palette.grey[2]), bg = H.hex(colors.palette.grey[9]) }),
		SpecialKey({ fg = H.hex(colors.palette.grey[7]) }),
		SpellBad({ fg = H.hex(colors.primary) }),
		SpellCap({ fg = H.hex(colors.palette.grey[1]) }),
		SpellLocal({ fg = H.hex(colors.palette.grey[6]) }),
		SpellRare({ fg = H.hex(colors.primary) }),

		StatusLine({ bg = H.hex(colors.background) }),
		TabLineSel({ fg = H.hex(colors.white) }),
		Title({ fg = H.hex(colors.palette.grey[4]) }),
		VisualNOS({ fg = H.hex(colors.primary), bg = H.hex(colors.palette.grey[9]) }),
		WarningMsg({ fg = H.hex(colors.primary) }),
		WinSeparator({ fg = H.hex(colors.bg_accent) }),
		Folded({ bg = H.hex(colors.background) }),
		WinBar({ bg = H.hex(colors.background) }),
		WinBarNC({ bg = H.hex(colors.background), gui = "bold" }),
	}
end)

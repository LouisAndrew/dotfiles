local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function()
	return {
		DiagnosticSource({ fg = H.hex(colors.primary) }),
		DiagnosticPos({ fg = H.hex(colors.mfed_7) }),
		DiagnosticWord({ fg = H.hex(colors.white) }),
		DiagnosticVirtualTextError({ fg = H.hex(colors.diagnostic.error), bg = H.hex(colors.misc.remove) }),

		DiagnosticError({ fg = H.hex(colors.diagnostic.error) }),
		DiagnosticWarn({ fg = H.hex(colors.diagnostic.warn) }),
		DiagnosticInfo({ fg = H.hex(colors.diagnostic.info) }),
		DiagnosticHint({ fg = H.hex(colors.diagnostic.hint) }),

		DiagnosticFloatingError({ DiagnosticError }),
		DiagnosticFloatingWarn({ DiagnosticWarn }),
		DiagnosticFloatingInfo({ DiagnosticInfo }),
		DiagnosticFloatingHint({ DiagnosticHint }),

		DiagnosticUnderlineError({ gui = "underline", sp = H.hex(colors.diagnostic.error) }),
		DiagnosticUnderlineWarn({ gui = "underline", sp = H.hex(colors.diagnostic.warn) }),
		DiagnosticUnderlineInfo({ gui = "underline", sp = H.hex(colors.diagnostic.info) }),
		DiagnosticUnderlineHint({ gui = "underline", sp = H.hex(colors.diagnostic.hint) }),
	}
end)

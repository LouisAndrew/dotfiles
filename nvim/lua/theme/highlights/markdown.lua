local lush = require("lush")
local H = require("theme.lush")
local colors = require("minimal_fedu")

---@diagnostic disable: undefined-global
return lush(function(injected)
	local sym = injected.sym

	return {
		RenderMarkdownCodeInline({ bg = H.hex(colors.background) }),
		RenderMarkdownCode({ bg = H.hex(colors.bg_shade) }),
		RenderMarkdownQuote({ fg = H.hex(colors.palette.indigo[2]) }),
		RenderMarkdownUpdate({ fg = H.hex(colors.palette.magenta[2]) }),
		RenderMarkdownTableHead({ fg = H.hex(colors.bg_accent) }),
		RenderMarkdownTableRow({ fg = H.hex(colors.bg_accent) }),
		RenderMarkdownWikiLink({ fg = H.hex(colors.palette.grey[6]) }),
		RenderMarkdownLink({ fg = H.hex(colors.palette.grey[6]) }),

		sym("@lsp.type.enumMember.markdown")({ fg = H.hex(colors.palette.indigo[2]) }),
		sym("@markup.link.label.markdown_inline")({ fg = H.hex(colors.palette.grey[6]) }),
		sym("@lsp.type.class.markdown")({ sym("@markup.link.label.markdown_inline") }),
		sym("@markup.link.url.markdown_inline")({ fg = H.hex(colors.foreground) }),
	}
end)

local block = "n-c:block-Cursor,i-ci:ver10-iCursor,v:hor100-vCursor,o:hor50-pCursor,r:hor100-rCursor"

return {
	statuscolumn = '%!v:lua.require("statuscol").myStatuscolumn()',
	nu = true,
	rnu = true,
	numberwidth = 1,

	-- indents etc
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	autoindent = true,
	wrap = false,
	laststatus = 3,
	smartindent = true,

	-- search
	ignorecase = true,
	smartcase = true,

	-- backspace
	backspace = "indent,eol,start",

	-- split
	splitright = true,
	splitbelow = true,
	background = "dark", -- set this to dark or light
	cursorline = true,
	cursorlineopt = "number",
	guicursor = block,
	undofile = true,
}

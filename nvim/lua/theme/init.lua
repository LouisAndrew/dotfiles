local M = {}

M.load_theme = function()
	local hl = require("utils").loaddir("lua/theme/highlights/*.lua")

	---@alias GroupDefinition { [1]: string, [2]: string, [3]?: string, bold?: boolean, italic?: boolean, link?: boolean, underline?: boolean, sp?: string, undercurl?: boolean }
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
					underline = l.underline,
					undercurl = l.undercurl,
					italic = l.italic,
					sp = l.sp,
					force = true,
				})
			end
		end
	end

	for _, config in pairs(hl) do
		apply_hl(config)
	end
end

M.load = function()
	vim.cmd("hi clear")

	vim.o.background = "dark"
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.g.colors_name = "minimal_fedu"
	M.load_theme()
end

return M

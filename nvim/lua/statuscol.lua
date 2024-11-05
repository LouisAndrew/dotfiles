local utils = require("utils")
local sc = {}

function sc.hl(hl_group)
	return "%#" .. hl_group .. "#"
end

function sc.num()
	local v_hl = ""

	local mode = vim.fn.strtrans(vim.fn.mode()):lower():gsub("%W", "")
	local is_cursor = vim.v.relnum == 0

	if mode == "v" then
		local v_range = utils.get_visual_range()
		local is_in_range = vim.v.lnum >= v_range[1] and vim.v.lnum <= v_range[3]
		if is_in_range then
			v_hl = sc.hl("vCursorLine")
		end

		if is_cursor then
			v_hl = v_hl .. sc.hl("CursorLineNr")
		end
	end

	local out = is_cursor and vim.v.lnum or vim.v.relnum
	return v_hl .. out
end

sc.folds = function()
	local lnum = vim.v.lnum
	local foldlevel = vim.fn.foldlevel(lnum)

	local foldlevel_before = vim.fn.foldlevel((lnum - 1) > 1 and lnum - 1 or 1)
	local foldlevel_after = vim.fn.foldlevel((lnum + 1) <= vim.fn.line("$") and (lnum + 1) or vim.fn.line("$"))

	local foldclosed = vim.fn.foldclosed(lnum)

	-- Line has nothing to do with folds so we will skip it
	if foldlevel == 0 then
		return " "
	end

	local hl = sc.hl("FoldColumn")
	-- Line is a closed fold(I know second condition feels unnecessary but I will still add it)
	if foldclosed ~= -1 and foldclosed == lnum then
		return hl .. "+"
	end

	-- I didn't use ~= because it couldn't make a nested fold have a lower level than it's parent fold and it's not something I would use
	if foldlevel > foldlevel_before or lnum == 1 then
		return hl .. "┌"
	end

	-- The line is the last line in the fold
	if foldlevel > foldlevel_after then
		return hl .. "└"
	end

	-- Line is in the middle of an open fold
	return hl .. "│"
end

function sc.sign()
	-- render sign (gitsigns) and align it to the right
	return "%s%="
end

function sc.space()
	return " "
end

-- %s%=%{v:relnum?v:relnum:v:lnum} %#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? " " : " ") : "  " }%*
-- tuts: https://www.reddit.com/r/neovim/comments/1djjc6q/statuscolumn_a_beginers_guide/, https://github.com/Wansmer/nvim-config/blob/76075092cf6a595f58d6150bb488b8b19f5d625a/lua/modules/status/components.lua
sc.myStatuscolumn = function()
	return table.concat({
		sc.sign(),
		sc.num(),
		sc.space(),
		sc.folds(),
		sc.space(),
		-- vim.w.display_fold,
	})
end

-- With this line we will be able to use myStatuscolumn by requiring this file and calling the function
return sc

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

function sc.sign()
	-- render sign (gitsigns) and align it to the right
	return "%s%="
end

function sc.space()
	return " "
end

local function ternary(condition, if_true, if_false)
	return condition .. " ? " .. if_true .. " : " .. if_false
end

local fold_chars = {
	closed = '"+"',
	opened = '"┌"',
	end_ = '"└"',
	middle = '"│"',
}

-- vimscript because it's a bit better than lua
-- Issue with lua: unfocusing window will make the foldcolumn disappear
function sc.fold()
	local hl = sc.hl("FoldColumn")
	local fold_before = "foldlevel(v:lnum - 1)"
	local fold_after = "foldlevel(v:lnum + 1)"
	local fold = "foldlevel(v:lnum)"
	local foldclosed = "foldclosed(v:lnum)"

	local is_end_t = ternary(fold .. " > " .. fold_after, fold_chars.end_, fold_chars.middle)
	local is_opened_start_t = ternary(fold .. " > " .. fold_before, fold_chars.opened, is_end_t)
	local is_closed_start_t =
		ternary(foldclosed .. " != -1 && " .. foldclosed .. " == v:lnum", fold_chars.closed, is_opened_start_t)
	local is_not_fold_t = ternary(fold .. " == 0", '" "', is_closed_start_t)

	return hl .. "%{" .. is_not_fold_t .. "}"
end

-- %s%=%{v:relnum?v:relnum:v:lnum} %#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? " " : " ") : "  " }%*
-- tuts: https://www.reddit.com/r/neovim/comments/1djjc6q/statuscolumn_a_beginers_guide/, https://github.com/Wansmer/nvim-config/blob/76075092cf6a595f58d6150bb488b8b19f5d625a/lua/modules/status/components.lua
function sc.myStatuscolumn()
	return table.concat({
		sc.sign(),
		sc.num(),
		sc.space(),
		-- sc.fold(),
		-- sc.space(),
	})
end

-- Disabling in favor of snacks statuscol
---@deprecated
return sc

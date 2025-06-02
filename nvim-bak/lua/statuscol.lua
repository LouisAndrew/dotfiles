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
			v_hl = sc.hl("vSelected")
		end

		if is_cursor then
			v_hl = v_hl .. sc.hl("CursorLineNr")
		end
	end

	local out = is_cursor and vim.v.lnum or vim.v.relnum
	-- Align to the right
	return "%=" .. v_hl .. out
end

function sc.sign()
	return "%s"
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

-- vimscript because it's a bit better than lua
-- Issue with lua: unfocusing window will make the foldcolumn disappear
vim.g.ENABLE_FOLD_CHARS = "false"
function sc.myStatuscolumn()
	local s = {
		sc.sign(),
		sc.num(),
		sc.space(),
	}

	if vim.g.ENABLE_FOLD_CHARS == "true" then
		table.insert(s, sc.fold())
		table.insert(s, sc.space())
	end

	return table.concat(s)
end

return sc

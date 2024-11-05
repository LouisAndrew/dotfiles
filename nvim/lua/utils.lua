---@param tab table
---@param val  string
---@return boolean
local function has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local nvim_config_path = function()
	return vim.fn.stdpath("config")
end

local pascal_case = function(str)
	local pascalStr = str:gsub("[-_]%l", string.upper):gsub("[-_]", "")
	return pascalStr:gsub("^%l", string.upper)
end

--- @param text string
local insert = function(text, append)
	local content = text
	if append then
		local current_line = vim.api.nvim_get_current_line()
		if current_line == "" then
			content = text
		else
			content = current_line .. " " .. text
		end
	end

	vim.api.nvim_set_current_line(content)
end

local function extract_component_name(
	args, -- text from i(2) in this example i.e. { { "456" } }
	_, -- parent snippet or parent node
	_ -- custom arguments
)
	local import_content = args[1][1]
	local component_name = string.gsub(import_content, ".+/(.*)$", "%1")

	if component_name == "" then
		return "snip"
	end

	local str = component_name:match("(.+)%..+$") or component_name
	return pascal_case(str)
end

local merge = function(first_table, second_table)
	for k, v in pairs(second_table) do
		first_table[k] = v
	end
end

-- https://github.com/Wansmer/nvim-config/blob/76075092cf6a595f58d6150bb488b8b19f5d625a/lua/utils.lua#L83
local function char_on_pos(pos)
	pos = pos or vim.fn.getpos(".")
	return tostring(vim.fn.getline(pos[1])):sub(pos[2], pos[2])
end

--  https://neovim.discourse.group/t/how-do-you-work-with-strings-with-multibyte-characters-in-lua/2437/4
local function char_byte_count(s, i)
	if not s or s == "" then
		return 1
	end

	local char = string.byte(s, i or 1)

	-- Get byte count of unicode character (RFC 3629)
	if char > 0 and char <= 127 then
		return 1
	elseif char >= 194 and char <= 223 then
		return 2
	elseif char >= 224 and char <= 239 then
		return 3
	elseif char >= 240 and char <= 244 then
		return 4
	end
end

-- https://github.com/Wansmer/nvim-config/blob/76075092cf6a595f58d6150bb488b8b19f5d625a/lua/utils.lua#L83
local function get_visual_range()
	local sr, sc = unpack(vim.fn.getpos("v"), 2, 3)
	local er, ec = unpack(vim.fn.getpos("."), 2, 3)

	-- To correct work with non-single byte chars
	local byte_c = char_byte_count(char_on_pos({ er, ec }))
	ec = ec + (byte_c - 1)

	local range = {}

	if sr == er then
		local cols = sc >= ec and { ec, sc } or { sc, ec }
		range = { sr, cols[1] - 1, er, cols[2] }
	elseif sr > er then
		range = { er, ec - 1, sr, sc }
	else
		range = { sr, sc - 1, er, ec }
	end

	return range
end

local function pad_start(n, width)
	local len = width - #tostring(n)
	return len < 1 and n or (" "):rep(len) .. n
end

return {
	has_value = has_value,
	dump = dump,
	nvim_config_path = nvim_config_path(),
	insert = insert,
	CONST = {
		truthy = 1,
		falsy = 0,
		emptyString = "",
	},
	pascal_case = pascal_case,
	extract_component_name = extract_component_name,
	merge = merge,
	get_visual_range = get_visual_range,
	pad_start = pad_start,
}

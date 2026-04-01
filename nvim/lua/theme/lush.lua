local lush = require("lush")
local hsl = lush.hsl

local M = {}

function M.hex(color)
	if not color then
		return nil
	end

	if #color == 9 then
		return hsl(color:sub(1, 7))
	end

	return hsl(color)
end

return M

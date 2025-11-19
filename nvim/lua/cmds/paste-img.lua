local pngpasteDest = os.getenv("VAULT_PATH") .. "/assets/imgs"
local utils = require("utils")

local split_by_space = function(s)
	local words = {}
	for word in s:gmatch("[%a%-_]+") do
		table.insert(words, word)
	end
	return words
end

return function(args)
	local words = split_by_space(args["args"] or "")
	local dir = words[2] or pngpasteDest

	local now = os.date("%Y-%m-%dZ%H:%M:%S")
	local filename = words[1] or now

	local dest = dir .. "/" .. filename .. ".png"
	os.execute("pngpaste " .. '"' .. dest .. '"')
	utils.insert(" ![[" .. filename .. ".png]]", true)
end

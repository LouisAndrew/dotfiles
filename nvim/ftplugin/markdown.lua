local high_level_dir = {
	"area",
	"projects",
}

-- organize
vim.keymap.set("n", "<leader>ok", function()
	if not package.loaded["obsidian"] then
		return
	end

	local obs = require("obsidian")
	local client = obs.get_client()
	local n = client:current_note(0)

	if n == nil then
		return
	end

	for _, tag in pairs(n.tags) do
		for _, dir in ipairs(high_level_dir) do
			if string.match(tag, dir .. ".*") then
				local target_dir = client.dir.filename .. "/" .. tag
				local newpath = target_dir .. "/" .. n.path.stem .. ".md"

				if vim.fn.isdirectory(target_dir) == 0 then
					vim.fn.mkdir(target_dir, "p")
				end

				n.path:rename(newpath)
				vim.cmd("e " .. newpath)
				print("moved to " .. newpath)
				return
			end
		end
	end
end)

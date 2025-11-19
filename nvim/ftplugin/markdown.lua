---@param path string
local function get_directories(path)
	local dirs = {}
	local scandir = vim.loop.fs_scandir(path)
	if scandir then
		while true do
			local name, t = vim.loop.fs_scandir_next(scandir)
			if not name then
				break
			end
			if t == "directory" then
				table.insert(dirs, name)
			end
		end
	end

	return dirs
end

local high_level_dir = {
	"area",
	"projects",
	"books",
}

---@param n obsidian.Note
---@param newpath string
local function move_note(n, newpath)
	n.path:rename(newpath)
	vim.cmd("e " .. newpath)
	print("moved to " .. newpath)
end

---@param client obsidian.Client
local function get_tag_groups(client)
	local t = {}
	for _, dir in ipairs(high_level_dir) do
		for _, subdir in ipairs(get_directories(client.dir.filename .. "/" .. dir)) do
			t[subdir] = dir
		end
	end

	return t
end

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

	if n:has_tag("archive") then
		local newpath = string.format("%s/archive/%s.md", client.dir.filename, n.path.stem)
		move_note(n, newpath)
		return
	end

	-- {[tag_value]: parent_dir}
	local tag_groups = get_tag_groups(client)
	for _, dir in ipairs(high_level_dir) do
		tag_groups[dir] = ""
	end

	for _, tag in pairs(n.tags) do
		for dir, parent in pairs(tag_groups) do
			if string.match(tag, dir .. ".*") then
				local parent_dir = parent ~= "" and "/" .. parent or ""
				local target_dir = string.format("%s%s/%s", client.dir.filename, parent_dir, tag)
				local newpath = string.format("%s/%s.md", target_dir, n.path.stem)

				if vim.fn.isdirectory(target_dir) == 0 then
					vim.fn.mkdir(target_dir, "p")
				end

				move_note(n, newpath)
				return
			end
		end
	end
end, { buffer = true })

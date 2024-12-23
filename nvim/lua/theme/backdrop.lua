local M = {}

--- @type integer
local winnr = nil
--- @type integer
local bufnr = nil

function M.show()
	local backdropName = "Backdrop"

	bufnr = vim.api.nvim_create_buf(false, true)
	winnr = vim.api.nvim_open_win(bufnr, false, {
		relative = "editor",
		row = 0,
		col = 0,
		width = vim.o.columns,
		height = vim.o.lines,
		focusable = false,
		style = "minimal",
		zindex = 1, -- ensure it's below the reference window
	})

	vim.api.nvim_set_hl(0, backdropName, { bg = "#000000", default = true })
	vim.wo[winnr].winhighlight = "Normal:" .. backdropName
	vim.wo[winnr].winblend = 50
	vim.bo[bufnr].buftype = "nofile"
end

function M.hide()
	if winnr ~= nil and vim.api.nvim_win_is_valid(winnr) then
		vim.api.nvim_win_close(winnr, true)
	end

	if bufnr ~= nil and vim.api.nvim_buf_is_valid(bufnr) then
		vim.api.nvim_buf_delete(bufnr, { force = true })
	end
end

return M

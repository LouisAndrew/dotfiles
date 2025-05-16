---@param client vim.lsp.Client
---@param bufnr integer
--- reference the eslint client for nvim <0.11
--- latest doesn't work that well since the command
--- is async - means we need to save the file twice (for format-on-save)
local function fix_all(client, bufnr)
	client:request_sync("workspace/executeCommand", {
		command = "eslint.applyAllFixes",
		arguments = {
			{
				uri = vim.uri_from_bufnr(bufnr),
				version = vim.lsp.util.buf_versions[bufnr],
				sync = true,
			},
		},
	}, nil, bufnr)
end

return {
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				fix_all(client, bufnr)
			end,
		})
	end,
}

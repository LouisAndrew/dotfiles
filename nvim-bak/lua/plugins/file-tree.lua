return {
	{
		"echasnovski/mini.files",
		version = "*",
		keys = {
			{ "_", "<cmd>:lua MiniFiles.open()<cr>" },
			{ "-", "<cmd>:lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>" },
		},
		opts = {
			mappings = {
				close = "<leader>w",
				go_in_plus = "<CR>",
				synchronize = "S",
			},
		},
	},
}

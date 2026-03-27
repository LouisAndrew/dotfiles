return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		{
			"jay-babu/mason-nvim-dap.nvim",
			cmd = { "DapInstall", "DapUninstall" },
			opts = {
				automatic_installation = true,
				handlers = {},
				ensure_installed = {},
			},
		},
	},
	keys = {
		{ "<leader>dt", "<cmd>:DapToggleBreakpoint<cr>" },
		{ "<leader>dp", "<cmd>:DapToggleBreakpoint<cr>" },

		{ "<leader>di", "<cmd>:DapStepInto<cr>" },
		{ "<leader>do", "<cmd>:DapStepOut<cr>" },
		{ "<leader>dj", "<cmd>:DapStepOver<cr>" },

		{ "<leader>dc", "<cmd>:DapContinue<cr>" },
		{ "<leader>dr", "<cmd>:DapContinue<cr>" },
		{ "<leader>dq", "<cmd>:DapTerminate<cr>" },
	},
	config = function()
		require("lsp.dap")
	end,
}

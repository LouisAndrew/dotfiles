return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		{
			"echasnovski/mini.ai",
			version = "*",
			opts = {
				mappings = {
					goto_left = "[",
					goto_right = "]",
				},
			},
			desc = "viq, vab, vib, vaq. not possible (or hard) with TS",
		},
		{ "echasnovski/mini.pairs", branch = "stable", opts = true },
	},
	config = function()
		-- Install parsers
		local ensure_installed = {
			"javascript",
			"typescript",
			"vue",
			"lua",
			"vim",
			"vimdoc",
			"html",
			"css",
			"graphql",
			"markdown",
			"markdown_inline",
		}

		-- Auto-install parsers
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
				if lang and not pcall(vim.treesitter.language.inspect, lang) then
					vim.cmd("TSInstall " .. lang)
				end
			end,
		})

		-- Install configured parsers on startup
		for _, lang in ipairs(ensure_installed) do
			if not pcall(vim.treesitter.language.inspect, lang) then
				vim.cmd("TSInstall " .. lang)
			end
		end

		-- Setup nvim-treesitter-textobjects
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local swap = require("nvim-treesitter-textobjects.swap")
		local move = require("nvim-treesitter-textobjects.move")

		-- Select keymaps
		local select_keymaps = {
			["a="] = "@assignment.outer",
			["i="] = "@assignment.inner",
			["l="] = "@assignment.lhs",
			["r="] = "@assignment.rhs",
			["a:"] = "@property.outer",
			["i:"] = "@property.inner",
			["l:"] = "@property.lhs",
			["r:"] = "@property.rhs",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["ai"] = "@conditional.outer",
			["ii"] = "@conditional.inner",
			["al"] = "@loop.outer",
			["il"] = "@loop.inner",
			["ax"] = "@call.outer",
			["ix"] = "@call.inner",
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
		}

		for keys, query in pairs(select_keymaps) do
			vim.keymap.set({ "x", "o" }, keys, function()
				select.select_textobject(query, "textobjects")
			end, { desc = "Select " .. query })
		end

		-- Swap keymaps
		vim.keymap.set("n", "<leader>na", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap parameter with next" })
		vim.keymap.set("n", "<leader>n:", function()
			swap.swap_next("@property.outer")
		end, { desc = "Swap property with next" })
		vim.keymap.set("n", "<leader>nm", function()
			swap.swap_next("@function.outer")
		end, { desc = "Swap function with next" })
		vim.keymap.set("n", "<leader>pa", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap parameter with previous" })
		vim.keymap.set("n", "<leader>p:", function()
			swap.swap_previous("@property.outer")
		end, { desc = "Swap property with previous" })
		vim.keymap.set("n", "<leader>pm", function()
			swap.swap_previous("@function.outer")
		end, { desc = "Swap function with previous" })

		-- Move keymaps - goto_next_start
		vim.keymap.set({ "n", "x", "o" }, "]x", function()
			move.goto_next_start("@call.outer", "textobjects")
		end, { desc = "Next function call start" })
		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Next method/function def start" })
		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			move.goto_next_start("@class.outer", "textobjects")
		end, { desc = "Next class start" })
		vim.keymap.set({ "n", "x", "o" }, "]i", function()
			move.goto_next_start("@conditional.outer", "textobjects")
		end, { desc = "Next conditional start" })
		vim.keymap.set({ "n", "x", "o" }, "]l", function()
			move.goto_next_start("@loop.outer", "textobjects")
		end, { desc = "Next loop start" })
		vim.keymap.set({ "n", "x", "o" }, "]s", function()
			move.goto_next_start("@local.scope", "locals")
		end, { desc = "Next scope" })
		vim.keymap.set({ "n", "x", "o" }, "]z", function()
			move.goto_next_start("@fold", "folds")
		end, { desc = "Next fold" })

		-- Move keymaps - goto_next_end
		vim.keymap.set({ "n", "x", "o" }, "]X", function()
			move.goto_next_end("@call.outer", "textobjects")
		end, { desc = "Next function call end" })
		vim.keymap.set({ "n", "x", "o" }, "]F", function()
			move.goto_next_end("@function.outer", "textobjects")
		end, { desc = "Next method/function def end" })
		vim.keymap.set({ "n", "x", "o" }, "]C", function()
			move.goto_next_end("@class.outer", "textobjects")
		end, { desc = "Next class end" })
		vim.keymap.set({ "n", "x", "o" }, "]I", function()
			move.goto_next_end("@conditional.outer", "textobjects")
		end, { desc = "Next conditional end" })
		vim.keymap.set({ "n", "x", "o" }, "]L", function()
			move.goto_next_end("@loop.outer", "textobjects")
		end, { desc = "Next loop end" })

		-- Move keymaps - goto_previous_start
		vim.keymap.set({ "n", "x", "o" }, "[x", function()
			move.goto_previous_start("@call.outer", "textobjects")
		end, { desc = "Prev function call start" })
		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Prev method/function def start" })
		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			move.goto_previous_start("@class.outer", "textobjects")
		end, { desc = "Prev class start" })
		vim.keymap.set({ "n", "x", "o" }, "[i", function()
			move.goto_previous_start("@conditional.outer", "textobjects")
		end, { desc = "Prev conditional start" })
		vim.keymap.set({ "n", "x", "o" }, "[l", function()
			move.goto_previous_start("@loop.outer", "textobjects")
		end, { desc = "Prev loop start" })

		-- Move keymaps - goto_previous_end
		vim.keymap.set({ "n", "x", "o" }, "[X", function()
			move.goto_previous_end("@call.outer", "textobjects")
		end, { desc = "Prev function call end" })
		vim.keymap.set({ "n", "x", "o" }, "[F", function()
			move.goto_previous_end("@function.outer", "textobjects")
		end, { desc = "Prev method/function def end" })
		vim.keymap.set({ "n", "x", "o" }, "[C", function()
			move.goto_previous_end("@class.outer", "textobjects")
		end, { desc = "Prev class end" })
		vim.keymap.set({ "n", "x", "o" }, "[I", function()
			move.goto_previous_end("@conditional.outer", "textobjects")
		end, { desc = "Prev conditional end" })
		vim.keymap.set({ "n", "x", "o" }, "[L", function()
			move.goto_previous_end("@loop.outer", "textobjects")
		end, { desc = "Prev loop end" })

		-- Repeatable moves
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
		vim.keymap.set({ "n", "x", "o" }, "<C-s>", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, "<C-a>", ts_repeat_move.repeat_last_move_previous)

		-- Incremental selection (built-in to nvim-treesitter)
		vim.keymap.set("n", "<C-t>", function()
			require("nvim-treesitter.incremental_selection").init_selection()
		end, { desc = "Init treesitter selection" })
		vim.keymap.set("x", "<C-p>", function()
			require("nvim-treesitter.incremental_selection").node_incremental()
		end, { desc = "Increment treesitter selection" })
		vim.keymap.set("x", "<C-n>", function()
			require("nvim-treesitter.incremental_selection").node_decremental()
		end, { desc = "Decrement treesitter selection" })

		-- Inspect highlight (replaces TSHighlightCapturesUnderCursor)
		vim.keymap.set("n", "<leader>ih", "<cmd>Inspect<cr>", { desc = "Inspect highlight" })
	end,
}

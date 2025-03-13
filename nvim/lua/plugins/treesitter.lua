return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/playground",
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- "nvim-treesitter/nvim-treesitter-context",
		{
			"danymat/neogen",
			config = true,
			keys = {
				{
					"<leader>ic",
					function()
						require("neogen").generate()
					end,
					"Generate annotation comment",
				},
			},
		},
		"windwp/nvim-ts-autotag",
		{
			"echasnovski/mini.ai",
			version = "*",
			opts = true,
			desc = "viq, vab, vib, vaq. not possible (or hard) with TS",
		},
		{ "echasnovski/mini.pairs", branch = "stable", opts = true },
		{
			"RRethy/vim-illuminate",
			config = function()
				require("illuminate").configure({
					min_count_to_highlight = 2,
					delay = 200,
					filetypes_denylist = {
						"dirbuf",
						"dirvish",
						"NvimTree",
						"DiffviewFiles",
						"DiffviewFileHistory",
						"qf",
					},
				})
			end,
		},
	},
	config = function()
		local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

		parser_configs.lua_patterns = {
			install_info = {
				url = "https://github.com/OXY2DEV/tree-sitter-lua_patterns",
				files = { "src/parser.c" },
				branch = "main",
			},
		}

		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		require("nvim-treesitter.configs").setup({
			ensure_installed = {
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
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			autotag = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
						["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

						-- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
						["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
						["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
						["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
						["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

						["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
						["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

						["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
						["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

						["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

						["ax"] = { query = "@call.outer", desc = "Select outer part of a function call" },
						["ix"] = { query = "@call.inner", desc = "Select inner part of a function call" },

						["af"] = {
							query = "@function.outer",
							desc = "Select outer part of a method/function definition",
						},
						["if"] = {
							query = "@function.inner",
							desc = "Select inner part of a method/function definition",
						},

						["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
						["<leader>n:"] = "@property.outer", -- swap object property with next
						["<leader>nm"] = "@function.outer", -- swap function with next
					},
					swap_previous = {
						["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
						["<leader>p:"] = "@property.outer", -- swap object property with prev
						["<leader>pm"] = "@function.outer", -- swap function with previous
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]x"] = { query = "@call.outer", desc = "Next function call start" },
						["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
						["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]l"] = { query = "@loop.outer", desc = "Next loop start" },

						-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
						-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
						["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
					},
					goto_next_end = {
						["]X"] = { query = "@call.outer", desc = "Next function call end" },
						["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
						["]C"] = { query = "@class.outer", desc = "Next class end" },
						["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["]L"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["[x"] = { query = "@call.outer", desc = "Prev function call start" },
						["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
						["[c"] = { query = "@class.outer", desc = "Prev class start" },
						["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
					},
					goto_previous_end = {
						["[X"] = { query = "@call.outer", desc = "Prev function call end" },
						["[F"] = { query = "@function.outer", desc = "Prev method/function def end" },
						["[C"] = { query = "@class.outer", desc = "Prev class end" },
						["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
					},
				},
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-t>",
					node_incremental = "<C-n>",
					scope_incremental = false,
					node_decremental = "<C-p>",
				},
			},
			playground = {
				enable = true,
			},
		})

		vim.keymap.set({ "n", "x", "o" }, "<C-s>", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, "<C-a>", ts_repeat_move.repeat_last_move_previous)
		vim.keymap.set("n", "<leader>ih", "<cmd>:TSHighlightCapturesUnderCursor<cr>")
	end,
}

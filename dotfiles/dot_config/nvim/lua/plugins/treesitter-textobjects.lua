local options = {
	textobjects = {
		select = {
			enable = true,
			disable = { "markdown" },

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {

				-- You can use the capture groups defined in textobjects.scm
				["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
				["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
				["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
				["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

				["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
				["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

				["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
				["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

				["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
				["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

				["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
				["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

				["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
				["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

				["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["mf"] = { query = "@call.outer", desc = "Next function call start" },
				["mm"] = { query = "@function.outer", desc = "Next method/function def start" },
				["mc"] = { query = "@class.outer", desc = "Next class start" },
				["mi"] = { query = "@conditional.outer", desc = "Next conditional start" },
				["ml"] = { query = "@loop.outer", desc = "Next loop start" },
			},
			goto_next_end = {
				["mff"] = { query = "@call.outer", desc = "Next function call end" },
				["mmm"] = { query = "@function.outer", desc = "Next method/function def end" },
				["mcc"] = { query = "@class.outer", desc = "Next class end" },
			},
			goto_previous_start = {
				[",mf"] = { query = "@call.outer", desc = "Prev function call start" },
				[",mm"] = { query = "@function.outer", desc = "Prev method/function def start" },
				[",mc"] = { query = "@class.outer", desc = "Prev class start" },
			},
			goto_previous_end = {
				[",mff"] = { query = "@call.outer", desc = "Prev function call end" },
				[",mmm"] = { query = "@function.outer", desc = "Prev method/function def end" },
				[",mcc"] = { query = "@class.outer", desc = "Prev class end" },
			},
		},
	},
}

require("nvim-treesitter.configs").setup(options)

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, "'", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

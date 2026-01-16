local options = {
	-- TODO, put some work into configuring
}
local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")

require("telescope").setup({
	defaults = {
		path_display = { "smart" },
		mappings = {
			i = {
				["<c-t>"] = trouble.open_with_trouble,
				["<c-e>"] = actions.to_fuzzy_refine,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
			n = { ["<c-t>"] = trouble.open_with_trouble, ["<c-e>"] = actions.to_fuzzy_refine },
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")

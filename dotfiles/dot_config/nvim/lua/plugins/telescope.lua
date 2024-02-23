local options = {
	-- TODO, put some work into configuring
}
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble, ["<c-e>"] = actions.to_fuzzy_refine },
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

local tree = require("nvim-tree")

tree.setup({
	view = {
		width = 35,
		relativenumber = true,
	},
	renderer = {
		full_name = true,
		group_empty = true,
		special_files = {},
		symlink_destination = false,
		indent_markers = {
			enable = true,
		},
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
			git_placement = "signcolumn",
			show = {
				file = true,
				folder = false,
				folder_arrow = false,
				git = true,
			},
		},
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = { "help" },
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	filters = {
		custom = {
			".DS_Store",
		},
		dotfiles = false,
	},
	git = {
		ignore = false,
	},
	actions = {
		change_dir = {
			enable = false,
			restrict_above_cwd = true,
		},
		open_file = {
			resize_window = true,
			window_picker = {
				chars = "aoeui",
			},
		},
		remove_file = {
			close_window = false,
		},
	},
	log = {
		enable = false,
		truncate = true,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			diagnostics = false,
			git = false,
			profile = false,
			watcher = false,
		},
	},
})

local options = {
	ensure_installed = {
		"lua",
		"vim",
		"typescript",
		"graphql",
		"gotmpl",
		"yaml",
		"python",
		"c",
		"cpp",
		"bash",
		"bibtex",
		"cmake",
		"make",
		"comment",
		"css",
		"diff",
		"dockerfile",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"html",
		"http",
		"java",
		"json",
		"kotlin",
		"latex",
		"ninja",
		"php",
		"perl",
		"racket",
		"regex",
		"scheme",
		"scss",
		"sql",
		"toml",
		"yaml",
		"markdown",
		"markdown_inline",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)

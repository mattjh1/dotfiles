local options = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}

require("mason").setup(options)

require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"lua_ls",
		"pyright",
		"gopls",
		"marksman",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"prettierd",
		"stylua",
		"isort",
		"black",
		"pylint",
		"eslint_d",
		"gopls",
		"ts_ls",
		"lua_ls",
		"pyright",
	},
})

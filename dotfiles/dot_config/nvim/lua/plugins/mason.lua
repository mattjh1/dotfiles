local options = {
	automatic_installation = true,

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
		"tsserver",
		"html",
		"cssls",
		"tailwindcss",
		"svelte",
		"lua_ls",
		"graphql",
		"jsonls",
		"emmet_ls",
		"prismals",
		"pyright",
		"gopls",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true,
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
	},
})

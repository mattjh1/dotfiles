local options = {
	ensure_installed = { "lua_ls", "eslint_d", "pyright", "gopls" },
}

require("mason-lspconfig").setup(options)

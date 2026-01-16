local options = {
	ensure_installed = { "ts_ls", "lua_ls", "eslint_d", "pyright", "gopls" },
}

require("mason-lspconfig").setup(options)

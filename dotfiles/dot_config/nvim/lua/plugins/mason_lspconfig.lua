local options = {
	ensure_installed = { "ts_ls", "lua_ls", "eslint", "cssls", "jsonls", "pyright", "gopls" },
}

require("mason-lspconfig").setup(options)

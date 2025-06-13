local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "html" },
			condition = function(utils)
				return utils.root_has_file_matches("^config%.(yaml|toml)$")
					or utils.root_has_file("hugo.yaml")
					or utils.root_has_file("hugo.toml")
					or utils.root_has_file("layouts/index.html")
					or utils.root_has_file("content/_index.md")
			end,
		}),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.goimports,

		-- require("none-ls.formatting.autopep8"),
		require("none-ls.code_actions.eslint_d"),
		require("none-ls.diagnostics.eslint_d"),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
})

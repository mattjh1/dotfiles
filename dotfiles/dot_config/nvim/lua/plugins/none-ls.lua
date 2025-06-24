local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- Lua
		null_ls.builtins.formatting.stylua,

		-- HTML/Hugo (your existing setup)
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

		-- Python
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,

		-- Go
		null_ls.builtins.formatting.goimports,

		-- JavaScript/TypeScript
		require("none-ls.diagnostics.eslint_d").with({
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
			condition = function(utils)
				return utils.root_has_file({
					".eslintrc",
					".eslintrc.js",
					".eslintrc.json",
					"eslint.config.js",
				})
			end,
		}),
		require("none-ls.code_actions.eslint_d").with({
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
			condition = function(utils)
				return utils.root_has_file({
					".eslintrc",
					".eslintrc.js",
					".eslintrc.json",
					"eslint.config.js",
				})
			end,
		}),

		-- ========== MARKDOWN SUPPORT ==========

		-- Markdown linting
		null_ls.builtins.diagnostics.markdownlint.with({
			filetypes = { "markdown" },
			-- Optional: Add custom config
			extra_args = { "--config", vim.fn.expand("~/.markdownlint.json") },
			condition = function(utils)
				-- Only run if markdownlint config exists OR always run (remove condition for always)
				return utils.root_has_file({ ".markdownlint.json", ".markdownlint.yaml", ".markdownlintrc" }) or true -- Remove "or true" if you only want it when config exists
			end,
		}),

		-- Spell checking for markdown
		null_ls.builtins.diagnostics.codespell.with({
			filetypes = { "markdown" },
			-- Optional: customize args
			extra_args = { "--ignore-words-list", "obsidian,zettelkasten" },
		}),
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- Format on save
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

-- LSP Server config

-- tsserver
lspconfig.ts_ls.setup({
	capabilities = capabilities,
	on_attach = function(client)
		client.server_capabilities.docmentRangeFormattingProvider = false
	end,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

-- python
require("lspconfig").ruff.setup({})

require("lspconfig").pyright.setup({
	settings = {
		pyright = {
			-- Using Ruff's import organizer
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				-- Ignore all files for analysis to exclusively use Ruff for linting
				ignore = { "*" },
			},
		},
	},
})

-- lua
lspconfig["lua_ls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "on_attach" },
			},
		},
	},
})

-- golang
lspconfig.gopls.setup({
	filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtmltmpl" },
	settings = {
		gopls = {
			gofumpt = true,
			buildFlags = { "-tags=testable" },
		},
	},
})

if not configs.golangcilsp then
	configs.golangcilsp = {
		default_config = {
			cmd = { "golangci-lint-langserver" },
			root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
			init_options = {
				command = {
					"golangci-lint",
					"run",
					"--enable-all",
					"--disable",
					"lll",
					"--out-format",
					"json",
					"--issues-exit-code=1",
				},
			},
		},
	}
end
lspconfig.golangci_lint_ls.setup({
	filetypes = { "go", "gomod" },
})

require("lspconfig").marksman.setup({
	-- Optional: specific settings for Obsidian
	filetypes = { "markdown", "markdown.mdx" },
	root_dir = require("lspconfig.util").root_pattern(".obsidian", ".git"),
})

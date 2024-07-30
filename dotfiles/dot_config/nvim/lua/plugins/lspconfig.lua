local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require("lspconfig")

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
lspconfig.cssls.setup({
	capabilities = capabilities,
	settings = {
		scss = {
			lint = {
				idSelector = "warning",
				zeroUnits = "warning",
				duplicateProperties = "warning",
			},
			completion = {
				completePropertyWithSemicolon = true,
				triggerPropertyValueCompletion = true,
			},
		},
	},
	on_attach = function(client)
		client.server_capabilities.docmentRangeFormattingProvider = false
	end,
})
lspconfig.tsserver.setup({
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

lspconfig.gopls.setup({
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
})

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

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    -- Lua
    null_ls.builtins.formatting.stylua,

    -- Python
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,

    -- Go
    null_ls.builtins.formatting.goimports,

    -- JavaScript/TypeScript
    null_ls.builtins.formatting.prettierd.with({
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    }),
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
  },

  -- Auto-format on save if the client supports formatting
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

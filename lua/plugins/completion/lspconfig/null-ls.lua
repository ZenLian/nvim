local M = {}

function M.setup(on_attach)
  require('null-ls').setup({
    sources = {
      require('null-ls').builtins.diagnostics.luacheck.with({
        diagnostics_format = '#{m} (#{s})',
      }),
      require('null-ls').builtins.formatting.stylua,
      -- require("null-ls").builtins.completion.spell,
      -- require("null-ls").builtins.formatting.eslint_d,
      require('null-ls').builtins.diagnostics.eslint_d,
      require('null-ls').builtins.code_actions.eslint_d,
      require('null-ls').builtins.formatting.prettierd,
      -- markdown
      require('null-ls').builtins.diagnostics.markdownlint.with({
        diagnostics_format = '[#{c}] #{m} (#{s})',
      }),
      require('null-ls').builtins.formatting.markdownlint,
    },
    on_attach = on_attach,
  })
end

return M

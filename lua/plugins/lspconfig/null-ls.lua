local M = {}

function M.setup(on_attach)
  local null_ls = require('null-ls')
  null_ls.setup {
    sources = {
      -- lua
      null_ls.builtins.diagnostics.luacheck.with {
        diagnostics_format = '#{m} (#{s})',
      },
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.formatting.prettierd,
      -- markdown
      null_ls.builtins.diagnostics.markdownlint.with {
        diagnostics_format = '[#{c}] #{m} (#{s})',
      },
      null_ls.builtins.formatting.markdownlint,
      -- shell
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.formatting.beautysh,
    },
    on_attach = on_attach,
    border = 'single',
  }
end

return M

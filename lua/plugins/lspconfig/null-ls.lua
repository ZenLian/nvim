local M = {}

function M.setup(on_attach)
  local null_ls = require('null-ls')
  local builtins = null_ls.builtins
  null_ls.setup {
    sources = {
      -- lua
      builtins.diagnostics.luacheck.with {
        diagnostics_format = '#{m} (#{s})',
      },
      builtins.formatting.stylua,
      builtins.diagnostics.eslint_d,
      builtins.code_actions.eslint_d,
      builtins.formatting.prettierd,
      -- markdown
      builtins.diagnostics.markdownlint.with {
        diagnostics_format = '[#{c}] #{m} (#{s})',
      },
      builtins.formatting.markdownlint,
      -- shell
      builtins.diagnostics.shellcheck,
      builtins.code_actions.shellcheck,
      builtins.formatting.beautysh,
    },
    on_attach = on_attach,
    border = 'single',
    root_dir = require('null-ls.utils').root_pattern('.null-ls-root', 'Makefile', '.git', '.luarc.json', '.luacheckrc'),
  }
end

return M

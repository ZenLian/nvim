local M = {}

function M.setup(on_attach)
  require('mason-null-ls').setup {
    ensure_installed = {
      -- lua (need luarocks)
      -- 'stylua',
      -- 'luacheck',
      -- javascript
      -- 'eslint_d',
      -- shell
      -- 'shellcheck',
      -- 'beautysh',
    },
    -- NOTE: this means installing sources in null_ls.setup
    automatic_installation = false,
    handlers = {},
  }

  local null_ls = require('null-ls')
  -- local builtins = null_ls.builtins
  null_ls.setup {
    -- sources = {
    --   -- markdown
    --   builtins.diagnostics.markdownlint.with {
    --     diagnostics_format = '[#{c}] #{m} (#{s})',
    --   },
    --   builtins.formatting.markdownlint,
    --   -- shell
    --   builtins.diagnostics.shellcheck,
    --   builtins.code_actions.shellcheck,
    --   builtins.formatting.beautysh,
    -- },
    diagnostics_format = '#{m} (#{s})',
    on_attach = on_attach,
    border = 'single',
    root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.git', '.luarc.json', '.luacheckrc'),
  }
end

return M

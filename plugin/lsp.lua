vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig'
})

require('mason').setup({
  ui = {
    -- border = 'rounded',
    -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
    backdrop = 60,
    icons = {
      package_installed = '󰄬',
      package_pending = '󰑓',
      package_uninstalled = '●',
    },
  }
})

--------------------------------------------------------------------------------
-- setup diagnostics
--------------------------------------------------------------------------------
local icons = require('zenlian.config').icons.diagnostics
local signs = {
  [vim.diagnostic.severity.ERROR] = icons.Error,
  [vim.diagnostic.severity.WARN] = icons.Warn,
  [vim.diagnostic.severity.INFO] = icons.Info,
  [vim.diagnostic.severity.HINT] = icons.Hint,
}
local diagnostics_opts = {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    source = 'if_many',
    spacing = 4,
    ---@param diagnostic vim.Diagnostic
    prefix = function(diagnostic)
      return signs[diagnostic.severity]
    end
  },
  signs = {
    text = signs,
  },
}
vim.diagnostic.config(diagnostics_opts)

--------------------------------------------------------------------------------
-- lsp config
--------------------------------------------------------------------------------
vim.lsp.enable({
  'lua_ls'
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     local buf = args.buf
--
--     local map = require('zenlian.util').keymap.set
--
--     map({
--       {
--         'K',
--         function()
--           vim.lsp.buf.hover({
--             border = 'rounded'
--           })
--         end,
--         desc = 'Goto Implementations',
--         nowait = true
--       }
--       {
--         '[[',
--         function()
--           Snacks.words.jump(-1, true)
--         end,
--         desc = 'Previous Word',
--       },
--       {
--         ']]',
--         function()
--           Snacks.words.jump(1, true)
--         end,
--         desc = 'Next Word',
--       },
--     }, { buffer = buf })
--     vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({border = 'rounded'}) end, )
--   end
-- })

vim.pack.add { 'https://github.com/mason-org/mason.nvim' }

require('mason').setup {
  ui = {
    -- border = 'rounded',
    -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
    backdrop = 60,
    icons = {
      package_installed = '󰄬',
      package_pending = '󰑓',
      package_uninstalled = '●',
    },
  },
}

--------------------------------------------------------------------------------
-- lsp config
--------------------------------------------------------------------------------
vim.lsp.enable {
  'lua_ls',
  'ty', -- python
  'clangd',
}

-- enable lsp features
-- vim.lsp.codelens.enable(true)
-- vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local buf = ev.buf

    if client ~= nil then
      if client:supports_method('textDocument/foldingRange') then
        local win = vim.api.nvim_get_current_win()
        vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
      end

      -- TODO: split into lang/*
      -- if client.server_info.name == 'clangd' then
      --   vim.keymap.set(
      --     'n',
      --     '<leader>lo',
      --     '<cmd>LspClangdSwitchSourceHeader<cr>',
      --     { desc = 'Switch Source/Header (C/C++)' }
      --   )
      -- end
    end

    -- lsp keymaps
    local map = require('zenlian.util').keymap.set
    map({
      { 'K', vim.lsp.buf.hover, desc = 'Hover Documentation' },
      { 'gd', '<cmd>FzfLua lsp_definitions<cr>', desc = 'Goto Definitions' },
      { 'gra', vim.lsp.buf.code_action, mode = { 'n', 'x' } },
      { 'gri', '<cmd>FzfLua lsp_implementations<cr>', desc = 'Goto Implementations' },
      { 'grn', vim.lsp.buf.rename },
      { 'grr', '<cmd>FzfLua lsp_references<cr>', desc = 'Goto References' },
      { 'grt', '<cmd>FzfLua lsp_typedefs<cr>', desc = 'Goto Type Definitions' },
      { 'grn', vim.lsp.codelens.run },
      { 'gO', vim.lsp.buf.document_symbol },
      { '<C-s>', vim.lsp.buf.signature_help, mode = { 'i' } },
      -- gx handles textDocument/documentLink
    }, { buffer = buf, nowait = true })
  end,
})

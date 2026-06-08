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
    end

    -- lsp keymaps
    local map = require('zenlian.util.keymap').set
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

-- lsp progress for notify
vim.api.nvim_create_autocmd('LspProgress', {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
      id = 'lsp_progress',
      title = 'LSP Progress',
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == 'end' and ' '
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

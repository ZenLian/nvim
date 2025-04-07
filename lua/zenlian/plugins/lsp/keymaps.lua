local M = {}
local Util = require('zenlian.util')

-- @param client
-- @param bufnr: number
-- @param keys: LazyKeySpec[]
M.on_attach = function(client, bufnr, keys)
  local map = Util.keymap.set
  local lsp = Util.lsp

  map({
    { 'gd', vim.lsp.buf.definition, desc = 'Goto Definition' },
    { 'gr', vim.lsp.buf.references, desc = 'Goto References', nowait = true },
    {
      '[[',
      function()
        Snacks.words.jump(-1, true)
      end,
      desc = 'Previous Word',
    },
    {
      ']]',
      function()
        Snacks.words.jump(1, true)
      end,
      desc = 'Next Word',
    },
  }, { buffer = bufnr })

  if lsp.has(client, 'signatureHelp') then
    map {
      'gK',
      function()
        vim.lsp.buf.signature_help()
      end,
      desc = 'Signature Help',
      buffer = bufnr,
    }
  end

  if keys then
    map(keys, { buffer = bufnr })
  end
end

return M

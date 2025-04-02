local M = {}
local Util = require('zenlian.util')

M.on_attach = function(client, bufnr)
  local map = Util.keymap.set
  local lsp = Util.lsp

  map({
    { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
    { "gr", vim.lsp.buf.references, desc = "Goto References", nowait = true },
  }, {buffer = bufnr})

  if lsp.has(client, 'signatureHelp') then
    map { "gK", function() vim.lsp.buf.signature_help() end, desc = "Signature Help", buffer = bufnr }
  end
end

return M

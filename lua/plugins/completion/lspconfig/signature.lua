local M = {}

-- M.on_attach = function(client, bufnr)
M.on_attach = function(_, bufnr)
  -- if not client.supports_method('textDocument/signatureHelp') then
  --   return
  -- end
  require('lsp_signature').on_attach({
    bind = true,
    handler_opts = {
      border = 'single',
    },
    hint_prefix = '😽 ',
    hint_scheme = 'LspSignatureActiveParameter',
  }, bufnr)
end

return M

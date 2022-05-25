local M = {}

-- TODO: use ray-x/lsp_signature.nvim
M.on_attach = function(client, bufnr)
  if not client.supports_method('textDocument/signatureHelp') then
    return
  end
  local trigger_chars = client.server_capabilities.signatureHelpTriggerCharacters or {}
  -- trigger_chars = { "," }
  for _, c in ipairs(trigger_chars) do
    vim.keymap.set('i', c, function()
      vim.defer_fn(function()
        pcall(vim.lsp.buf.signature_help)
      end, 0)
      return c
    end, {
      noremap = true,
      silent = true,
      buffer = bufnr,
      expr = true,
    })
  end
end

return M

local M = {}

M.on_attach = function(client, bufnr)
  local map = vim.keymap.set
  map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition", buffer = bufnr })
end

return M
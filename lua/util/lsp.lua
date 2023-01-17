local M = {}

---@return boolean Whether at least one LSP client supports `capability`.
M.has_capability = function(capability)
  -- param check
  if not capability then
    return true
  end

  local clients = vim.lsp.get_active_clients { bufnr = 0 }
  for _, client in ipairs(clients) do
    -- local capabilities = client.server_capabilities
    if vim.tbl_get(client.server_capabilities, capability) then
      return true
    end
  end
  return false
end

return M

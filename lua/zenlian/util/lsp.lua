local M = {}

--- return true if lsp client has method
function M.has(client, method)
  method = method:find('/') and method or 'textDocument/' .. method
  if client.supports_method(method) then
    return true
  end
  return false
end

--- returns root directory based on lsp
--- @param bufnr integer The buffer number
function M.root(bufnr)
  vim.api.nvim_buf_get_name(bufnr)
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  for _, client in ipairs(clients) do
    -- workspace folders
    local workspace = client.config.workspace_folders
    for _, ws in pairs(workspace or {}) do
      if ws.uri then
        return vim.uri_to_fname(ws.uri)
      end
    end
    -- root_dir
    if client.root_dir then
      return client.root_dir
    end
  end
  return nil
end

return M

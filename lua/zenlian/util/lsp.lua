local M = {}

-- return true if lsp client has method
function M.has(client, method)
  method = method:find("/") and method or "textDocument/" .. method
  if client.supports_method(method) then
    return true
  end
  return false
end

return M

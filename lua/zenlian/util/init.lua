local PREFIX = ...
local M = {}

M.trigger_event = function(event, pattern)
  if pattern == nil then
    vim.api.nvim_exec_autocmds(event, { modeline = false })
  else
    vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
  end
end

M.on_user_event = function(event, callback)
  vim.api.nvim_create_autocmd("User", {
    pattern = event,
    callback = callback
  })
end

return setmetatable(M, {
  __index = function(_, key)
    local module = require(PREFIX .. '.' .. key)
    rawset(M, key, module)
    return module
  end,
})

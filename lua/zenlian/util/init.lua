local M = {}

--- Merge options into default table
---@param defaults? table The default options that will be merged into
---@param opts? table The new options that should be merged
function M.tbl_extend(defaults, opts)
  opts = opts or {}
  return defaults and vim.tbl_deep_extend('force', defaults, opts) or opts
end

--- trigger a event
--- to run a user event: `trigger_event("User MyEvent")`
--- to run a Neovim event: `trigger_event("InsertEnter")`
--- @param event string event name
--- @param urgent? boolean trigger immediately instead of scheduling. default false.
M.trigger_event = function(event, urgent)
  local function trigger()
    local is_user_event = string.match(event, 'User ') ~= nil
    if is_user_event then
      event = event:gsub('^User ', '')
      vim.api.nvim_exec_autocmds('User', { pattern = event, modeline = false })
    else
      vim.api.nvim_exec_autocmds(event, { modeline = false })
    end
  end
  if urgent then
    trigger()
  else
    vim.schedule(trigger)
  end
end

M.on_user_event = function(event, callback)
  vim.api.nvim_create_autocmd('User', {
    pattern = event,
    callback = callback,
  })
end

M.on_vim_enter = function(callback)
  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function ()
      vim.schedule(callback)
    end
  })
end

--- get root directory of buffer based on:
--- * lsp
--- * root patterns
--- @param bufnr? integer
M.root = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.b[bufnr].zl_rootdir then
    local lsputil = require('zenlian.util.lsp')
    local root_pattern = { '.git', '.editorconfig' }
    vim.b[bufnr].zl_rootdir = lsputil.root(bufnr) or vim.fs.root(bufnr, root_pattern)
  end
  return vim.b[bufnr].zl_rootdir
end

---------- Lazy Utils ----------

local PREFIX = ...
return setmetatable(M, {
  __index = function(_, key)
    local module = require(PREFIX .. '.' .. key)
    rawset(M, key, module)
    return module
  end,
})

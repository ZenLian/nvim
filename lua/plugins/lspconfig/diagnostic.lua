local M = {}
local util = require('util')

local TITLE = 'Diagnostics'
M.enable = true

function M.setup()
  local signs = {
    -- icons / text used for a diagnostic
    Error = '',
    Warn = '',
    Hint = '',
    Info = '',
  }
  for serverity, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. serverity
    vim.fn.sign_define(hl, {
      text = icon,
      texthl = hl,
      numhl = '',
    })
  end
end

function M.toggle(value)
  if type(value) == 'boolean' then
    M.enable = value
  else
    M.enable = not M.enable
  end
  if M.enable then
    vim.diagnostic.enable()
    util.info('Toggle diagnostics on', TITLE)
  else
    vim.diagnostic.disable()
    util.warn('Toggle diagnostics off', TITLE)
  end
end

return M

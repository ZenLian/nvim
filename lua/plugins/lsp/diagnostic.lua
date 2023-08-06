local config = require("config")

local M = {}

M.enabled = config.lsp.diagnostic

if config.icons.enabled then
  M.signs = {
    -- icons / text used for a diagnostic
    Error = '',
    Warn = '',
    Hint = '',
    Info = '',
  }
else
  M.signs = {
    Error = 'E',
    Warn = 'W',
    Hint = 'H',
    Info = 'I',
  }
end

function M.setup()
  -- signs
  for severity, icon in pairs(M.signs) do
    local hl = 'DiagnosticSign' .. severity
    vim.fn.sign_define(hl, {
      text = icon,
      texthl = hl,
      numhl = '',
    })
  end
  -- config
  vim.diagnostic.config {
    severity_sort = true,
  }
end

function M.toggle(value)
  if type(value) == 'boolean' then
    M.enabled = value
  else
    M.enabled = not M.enabled
  end
  if M.enabled then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end

return M

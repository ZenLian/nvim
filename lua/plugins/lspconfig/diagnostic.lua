local M = {}

M.enable = true

M.signs = {
  -- icons / text used for a diagnostic
  Error = '',
  Warn = '',
  Hint = '',
  Info = '',
}

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
    M.enable = value
  else
    M.enable = not M.enable
  end
  if M.enable then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end

return M

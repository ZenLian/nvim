local M = {}

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

return M

local M = {
  icons = {
    error = '',
    warn = '',
    info = '',
    hint = '󰌵',
  },
}

local map = vim.keymap.set
local vimsev = vim.diagnostic.severity

local signs = {
  [vimsev.ERROR] = M.icons.error,
  [vimsev.WARN] = M.icons.warn,
  [vimsev.INFO] = M.icons.info,
  [vimsev.HINT] = M.icons.hint,
}

vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = {
    source = 'if_many',
    spacing = 4,
    prefix = function(diagnostic)
      return signs[diagnostic.severity]
    end,
  },
  signs = {
    text = signs,
  },
}

local function diagnostics_goto(count, severity)
  local sev = severity and vimsev[severity] or nil
  return function()
    vim.diagnostic.jump { count = count, float = true, severity = sev }
  end
end

-- diagnostics
-- :h diagnostics-defaults
map('n', '<c-w>d', vim.diagnostic.open_float, { desc = 'Show Diagnostics' })
map('n', ']d', diagnostics_goto(1), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostics_goto(-1), { desc = 'Previous Diagnostic' })
map('n', ']e', diagnostics_goto(1, 'ERROR'), { desc = 'Next Error Diagnostic' })
map('n', '[e', diagnostics_goto(-1, 'ERROR'), { desc = 'Previous Error Diagnostic' })
map('n', ']w', diagnostics_goto(1, 'WARN'), { desc = 'Next Warning Diagnostic' })
map('n', '[w', diagnostics_goto(-1, 'WARN'), { desc = 'Previous Warning Diagnostic' })

return M

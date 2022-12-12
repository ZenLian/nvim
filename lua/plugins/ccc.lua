local M = {}

function M.config()
  local ccc = require('ccc')
  ccc.setup {
    highlighter = {
      auto_enable = true,
    },
  }
end

return M

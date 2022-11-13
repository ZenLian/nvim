local config = function()
  local notify = require('notify')

  notify.setup {
    stages = 'slide',
    timeout = 2000,
  }

  vim.notify = notify
  -- LSP
  -- https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes#lsp-messages
  local severity = {
    'error',
    'warn',
    'info',
    'info', -- map both hint and info to info?
  }
  vim.lsp.handlers['window/showMessage'] = function(_, method, params, _)
    vim.notify(method.message, severity[params.type])
  end
end

return {
  config = config,
}

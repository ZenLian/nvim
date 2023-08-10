local spec = {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  opts = {
    -- stages = 'slide',
    timeout = 5000,
    max_width = 30,
    max_height = 8,
  },
}

spec.config = function(_, opts)
  local C = require('config')
  local notify = require('notify')

  if not C.icons.enabled then
    opts.icons = {
      DEBUG = 'D',
      ERROR = 'E',
      INFO = 'I',
      TRACE = 'T',
      WARN = 'W',
    }
  end
  notify.setup(opts)

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

spec.keys = {
  {
    '<Leader><CR>',
    function()
      require('notify').dismiss()
    end,
    desc = 'Dismiss notify',
  },
}

return { spec }

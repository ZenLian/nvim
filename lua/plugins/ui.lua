return {
  {
    "folke/noice.nvim",
    opts = {
      messages = {
        view = 'mini',
        view_error = 'mini',
        view_warn = 'mini',
      },
      notify = {
        view = 'mini',
      },
      lsp = {
        message = {
          view = 'notify',
        },
      },
      views = {
        mini = {
          timeout = 3000,
        },
      },
    },
  },
  -- [NEW] rainbow
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'LazyFile',
    config = function()
      local rainbow = require('rainbow-delimiters')
      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = rainbow.strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          html = 'rainbow-tags',
        },
      }
    end,
  },
}

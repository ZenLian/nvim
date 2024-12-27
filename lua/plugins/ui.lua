return {
  {
    "folke/noice.nvim",
    opts = {
      views = {
        mini = {
          timeout = 3000,
        },
      },
    },
  },
  {
    'folke/snacks.nvim',
    opts = {
      notifier = { enabled = false },
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

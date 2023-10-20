local spec = {
  'HiPhish/rainbow-delimiters.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = function(_, _)
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
}

return { spec }

return {
  -- disable indentscope
  { 'echasnovski/mini.indentscope', enabled = false },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        include = {
          node_type = {
            lua = { 'return_statement', 'table_constructor' },
          },
        },
      },
    },
  },

  -- rainbow
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

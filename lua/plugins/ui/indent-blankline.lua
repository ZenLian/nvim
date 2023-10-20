local spec = {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufRead', 'BufNewFile' },
  -- enabled = false,
  opts = {
    indent = {
      char = '▏',
    },
    scope = {
      show_start = false,
      include = {
        node_type = {
          lua = { 'return_statement', 'table_constructor' },
        },
      },
    },
  },
  config = function(_, opts)
    require('ibl').setup(opts)
  end,
}

return { spec }

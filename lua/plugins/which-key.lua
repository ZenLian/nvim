local spec = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = true,
        text_objects = true,
        nav = false,
        z = true,
        g = false,
      },
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    window = {
      winblend = 3,
    },
    show_help = false,
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)

    wk.register {
      ['g'] = { name = '+goto' },
      ['['] = { name = '+previous' },
      [']'] = { name = '+next' },
      ['<leader>'] = {
        ['b'] = { name = '+buffer' },
        ['f'] = { name = '+file' },
        ['c'] = { name = '+code' },
        ['g'] = {
          name = '+git',
          ['h'] = { name = '+hunks' },
        },
        ['p'] = { name = '+package' },
        ['z'] = { name = '+zen' },
      },
    }
  end,
}

return { spec }

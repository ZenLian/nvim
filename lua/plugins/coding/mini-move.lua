local spec = {
  'echasnovski/mini.move',
  keys = {
    { '<A-H>', mode = { 'n', 'v' } },
    { '<A-J>', mode = { 'n', 'v' } },
    { '<A-K>', mode = { 'n', 'v' } },
    { '<A-L>', mode = { 'n', 'v' } },
  },
  config = function()
    require('mini.move').setup()
  end,
}

return { spec }

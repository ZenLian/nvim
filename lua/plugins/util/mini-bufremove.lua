local spec = {
  'echasnovski/mini.bufremove',
  keys = {
    {
      '<Leader>bd',
      function()
        require('mini.bufremove').delete()
      end,
      desc = 'Delete buffer',
    },
    {
      'Q',
      function()
        require('mini.bufremove').delete()
      end,
      desc = 'Delete buffer',
    },
  },
}

return { spec }

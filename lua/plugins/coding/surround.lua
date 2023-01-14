local spec = {
  'kylechui/nvim-surround',
  event = { 'BufRead', 'BufNewFile' },
  opts = {
    aliases = {
      ['b'] = { ')', '}', ']', '>' },
      ['q'] = { '"', "'", '`' },
      ['s'] = { '}', ']', ')', '>', '"', "'", '`' },
    },
  },
  -- config = true,
}

return { spec }

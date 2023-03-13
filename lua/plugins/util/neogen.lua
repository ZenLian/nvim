local spec = {
  'danymat/neogen',
  dependencies = 'nvim-treesitter',
  version = '*',
  cmd = 'Neogen',
  keys = {
    { '<Leader>N', '<cmd>lua require("neogen").generate()<cr>', desc = 'Generate doc' },
  },
  opts = {
    snippet_engine = 'luasnip',
    placeholders_hl = 'None',
  },
  -- config = true,
}

return { spec }

local spec = {
  'danymat/neogen',
  dependencies = 'nvim-treesitter',
  version = '*',
  cmd = 'Neogen',
  keys = {
    { '<Leader>nn', '<cmd>lua require("neogen").generate()<cr>' },
  },
  opts = {
    snippet_engine = 'luasnip',
    placeholders_hl = 'None',
  },
  -- config = true,
}

return { spec }

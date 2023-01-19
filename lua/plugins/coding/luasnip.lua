local spec = {
  'L3MON4D3/LuaSnip',
  version = '*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    history = true,
    -- updateevents = 'TextChanged,TextChangedI',
    delete_check_events = 'TextChanged',
  },
  config = function(_, opts)
    require('luasnip').setup(opts)
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_snipmate').lazy_load()
  end,
}

return spec

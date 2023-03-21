local spec = {
  'echasnovski/mini.starter',
  lazy = false,
  -- event = 'VeryLazy',
  config = function(_, opts)
    require('mini.starter').setup(opts)
  end,
}

return { spec }

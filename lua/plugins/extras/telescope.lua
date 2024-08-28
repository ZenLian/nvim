return {
  -- telescope-symbols
  {
    'nvim-telescope/telescope-symbols.nvim',
    enabled = function()
      return LazyVim.pick.want() == 'telescope'
    end,
    keys = {
      { '<leader>s;', LazyVim.pick('symbols'), desc = 'Symbols' },
    },
  },
}

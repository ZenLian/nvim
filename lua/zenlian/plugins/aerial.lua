---@type LazyPluginSpec[]
return {
  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>ls', '<cmd>AerialToggle<cr>', desc = 'Symbols (Aerial)' },
      { '<leader>;', '<cmd>AerialToggle<cr>', desc = 'Symbols (Aerial)' },
    },
    opts = {},
  },
}

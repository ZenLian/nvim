---@type LazyPluginSpec[]
return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts_extend = { 'spec', 'icons.rules' },
    opts = {
      preset = 'helix',
      spec = {
        { '<leader><tab>', group = 'Tabs' },
        { '<leader>b', group = 'Buffers' },
        { '<leader>f', group = 'Find(Files)' },
        { '<leader>g', group = 'Git', icon = { icon = '󰘬', color = 'orange' } },
        { '<leader>gh', group = 'Hunk' },
        { '<leader>l', group = 'Language', icon = '󰅩' },
        { '<leader>s', group = 'Search' },
        { '<leader>u', group = 'UI' },
        { '<leader>x', group = 'Diagnostics' },
        { '<leader>\\', group = 'Toggles' },
      },
      icons = {
        breadcrumb = '>',
        separator = '󰁔',
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show {
            global = false,
          }
        end,
        desc = 'Local keymaps (which-key)',
      },
      {
        '<c-w><space>',
        function()
          require('which-key').show {
            keys = '<c-w>',
            loop = true,
          }
        end,
        desc = 'Window Hydra Mode (which-key)',
      },
    },
  },
}

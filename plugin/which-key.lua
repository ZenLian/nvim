vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

require('which-key').setup({
  preset = 'helix',
  spec = {
    { '<leader><tab>', group = 'Tabs' },
    { '<leader>b', group = 'Buffers' },
    { '<leader>f', group = 'Find(Files)' },
    { '<leader>g', group = 'Git', icon = { icon = '󰘬', color = 'orange' } },
    { '<leader>gh', group = 'Hunk' },
    { '<leader>l', group = 'Language', icon = '󰅩' },
    { '<leader>n', group = 'Noice' },
    { '<leader>s', group = 'Search' },
    { '<leader>u', group = 'UI' },
    { '<leader>x', group = 'Diagnostics' },
    { '<leader>\\', group = 'Toggles' },
    { 'gr', group = 'Lsp', icon = '󰅩' }
  },
  icons = {
    breadcrumb = '>',
    separator = '󰁔',
  },
})

vim.keymap.set('n',
  '<leader>?',
  function()
    require('which-key').show {
      global = false,
    }
  end, {
    desc = 'Local keymaps (which-key)',
  }
)
vim.keymap.set('n',
  '<c-w><space>',
  function()
    require('which-key').show {
      keys = '<c-w>',
      loop = true,
    }
  end,
  {
    desc = 'Window Hydra Mode (which-key)',
  }
)

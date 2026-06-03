vim.pack.add({
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/NeogitOrg/neogit'
})

require('diffview').setup({
  keymaps = {
    view = {
      ['q'] = '<cmd>DiffviewClose<cr>',
    },
    file_panel = {
      ['q'] = '<cmd>DiffviewClose<cr>',
    },
    file_history_panel = {
      ['q'] = '<cmd>DiffviewClose<cr>',
    },
  },
  view = {
    merge_tool = {
      layout = 'diff3_mixed',
    },
  },
})

require('neogit').setup({
  disable_commit_confirmation = true,
  signs = {
    section = { '', '' },
    item = { '', '' },
    hunk = { '', '' },
  },
})

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Neogit' })

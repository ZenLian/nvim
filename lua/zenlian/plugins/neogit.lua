vim.pack.add { 'https://github.com/NeogitOrg/neogit' }

require('neogit').setup {
  disable_commit_confirmation = true,
  signs = {
    section = { '', '' },
    item = { '', '' },
    hunk = { '', '' },
  },
}

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Neogit' })

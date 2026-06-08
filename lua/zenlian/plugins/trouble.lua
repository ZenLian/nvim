vim.pack.add { 'https://github.com/folke/trouble.nvim' }

require('trouble').setup {
  --auto_refresh = false,
  focus = true,
  keys = {
    ['<tab>'] = 'fold_toggle',
  },
}

local map = require('zenlian.util.keymap').set
map {
  {
    '<leader>xx',
    '<cmd>Trouble diagnostics toggle<cr>',
    desc = 'Diagnostics (Trouble)',
  },
  {
    '<leader>xX',
    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
    desc = 'Buffer Diagnostics (Trouble)',
  },
  {
    '<leader>xL',
    '<cmd>Trouble loclist toggle<cr>',
    desc = 'Location List (Trouble)',
  },
  {
    '<leader>xQ',
    '<cmd>Trouble qflist toggle<cr>',
    desc = 'Quickfix List (Trouble)',
  },
  {
    '<leader>;',
    '<cmd>Trouble symbols toggle focus=true follow=true<cr>',
    desc = 'Symbols (Trouble)',
  },
  {
    '<leader>ls',
    '<cmd>Trouble symbols toggle<cr>',
    desc = 'Symbols (Trouble)',
  },
  {
    '<leader>ll',
    '<cmd>Trouble lsp toggle<cr>',
    desc = 'LSP Definitions / references / ... (Trouble)',
  },
}

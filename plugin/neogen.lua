vim.pack.add({'https://github.com/danymat/neogen'})
require('neogen').setup({
  snippet_engine = 'nvim',
})

vim.keymap.set('n', '<leader>lg', require('neogen').generate, {desc = 'Generate Annotations (Neogen)'})

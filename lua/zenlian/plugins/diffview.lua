vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

require('diffview').setup {
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
}

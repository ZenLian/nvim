local spec = {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  keys = {
    { '<Leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' },
  },
}

return { spec }

return {
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
    keys = {
      { '<Leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' },
      { '<Leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Close diffview' },
    },
  },
}

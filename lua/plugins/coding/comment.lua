local spec = {
  'numToStr/Comment.nvim',
  event = { 'BufRead', 'BufNewFile' },
  keys = {
    { '<C-_>', '<Plug>(comment_toggle_linewise_current)' },
    { '<C-_>', '<Plug>(comment_toggle_linewise_visual)', mode = 'v' },
    { 'gc', mode = { 'n', 'v' } },
    { 'gb', mode = { 'n', 'v' } },
  },
  config = true,
}

return { spec }

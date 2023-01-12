local M = {
  packer = {
    event = { 'BufRead', 'BufNewFile' },
  },
}

function M.packer.config()
  require('Comment').setup {}
  vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)')
  vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')
end

return M

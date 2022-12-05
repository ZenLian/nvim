-- create or get group but don't clear it to not delete autocommands of other buffers
local group = vim.api.nvim_create_augroup('DrexCursor', { clear = false })
-- only clear buflocal autocommands
vim.api.nvim_clear_autocmds {
  group = group,
  buffer = 0,
}
vim.api.nvim_create_autocmd('CursorMoved', {
  group = group,
  desc = 'keep cursor fixed at column 0',
  buffer = 0,
  command = 'normal! 0',
})

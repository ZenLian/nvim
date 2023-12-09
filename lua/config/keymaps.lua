local Util = require('lazyvim.util')

local map = vim.keymap.set
local unmap = vim.keymap.del

local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
map('n', '<C-\\>', lazyterm, { desc = 'Terminal (root dir)' })
map('t', '<C-\\>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
unmap({ 'n', 't' }, '<C-/>')
unmap({ 'n', 't' }, '<C-_>')

map({ 'n', 'x' }, 'gh', '^', { desc = 'Start of line' })
map({ 'n', 'x' }, 'gl', '$', { desc = 'End of line' })
map({ 'n', 'x' }, 'gm', '%', { desc = 'Matching character' })

map('n', '<C-c>', '<cmd>normal! ciw<cr>a', { desc = 'Edit word' })

map('v', '<Tab>', '>gv', { desc = 'Indent right' })
map('v', '<S-Tab>', '<gv', { desc = 'Indent left' })

-- stylua: ignore start
-- lazygit
-- map("n", "<leader>gG", function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
-- map("n", "<leader>gG", function() Util.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

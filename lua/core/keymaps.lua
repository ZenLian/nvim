local keymap = vim.api.nvim_set_keymap

-- 快速保存和关闭
keymap('', '<leader>w', ':w!<CR>', {noremap=true, nowait=true})
keymap('', '<leader>q', ':q!<CR>', {noremap=true, nowait=true})
-- 关闭高亮
keymap('', '<leader><enter>', ':noh<CR>', {noremap=true, nowait=true})
-- Y 复制到行尾
keymap('n', 'Y', 'y$', {noremap=true, nowait=true})
-- Y 复制到剪贴板（visual mode）
keymap('v', 'Y', '"+y', {noremap=true, nowait=true})
-- 移动到行首/行尾
keymap('n', 'H', '^', {noremap=true, nowait=true})
keymap('n', 'L', '$', {noremap=true, nowait=true})
-- 连续缩进
keymap('v', '<', '<gv', {noremap=true, nowait=true})
keymap('v', '>', '>gv', {noremap=true, nowait=true})
keymap('v', '<Tab>', '<gv', {noremap=true, nowait=true})
keymap('v', '<S-Tab>', '>gv', {noremap=true, nowait=true})
-- repeat in visual mode
keymap('v', '.', ':normal .<CR>', {noremap=true, nowait=true})
-- 交换上下行
keymap('n', '<M-j>', 'mz:m+<cr>`z', {noremap=true, nowait=true})
keymap('n', '<M-k>', 'mz:m-2<cr>`z', {noremap=true, nowait=true})
keymap('n', '<M-j>', ":m'>+<cr>`<my`>mzgv`yo`z", {noremap=true, nowait=true})
keymap('n', '<M-j>', ":m'<-2<cr>`>my`<mzgv`yo`z", {noremap=true, nowait=true})

-- tab
keymap('n', '[t', ":tabprevious", {noremap=true, nowait=true})
keymap('n', ']t', ":tabnext", {noremap=true, nowait=true})


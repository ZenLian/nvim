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
keymap('v', '<M-j>', ":m'>+<cr>`<my`>mzgv`yo`z", {noremap=true, nowait=true})
keymap('v', '<M-k>', ":m'<-2<cr>`>my`<mzgv`yo`z", {noremap=true, nowait=true})

----------------------
--- plugin keymaps ---
----------------------

-----------------
--- packer ---
-----------------
vim.cmd [[nnoremap <silent> <leader>ps :PackerSync<CR>]]

-----------------
--- telescope ---
-----------------
vim.cmd [[nnoremap <silent> <C-p> :Telescope git_files<cr>]]
vim.cmd [[nnoremap <silent> <leader>ff :Telescope find_files<cr>]]
vim.cmd [[nnoremap <silent> <leader>fg :Telescope live_grep<cr>]]
vim.cmd [[nnoremap <silent> <leader>fb :Telescope buffers<cr>]]
vim.cmd [[nnoremap <silent> <leader>ft :Telescope help_tags<cr>]]
vim.cmd [[nnoremap <silent> <leader>fe :Telescope oldfiles<cr>]]
vim.cmd [[nnoremap <silent> <leader>fn :Telescope file_browser<cr>]]
-- frecency
vim.cmd [[nnoremap <silent> <leader>fh :Telescope frecency<cr>]]
-- project
vim.cmd [[nnoremap <silent> <leader>fp :Telescope project<cr>]]
-- neoclip
vim.cmd [[nnoremap <silent> <leader>fc :Telescope neoclip<cr>]]

------------------
--- bufferline ---
------------------
vim.cmd [[nnoremap <silent> [b :BufferLineCyclePrev<CR>]]
vim.cmd [[nnoremap <silent> ]b :BufferLineCycleNext<CR>]]
vim.cmd [[nnoremap <Leader>bb :BufferLinePick<CR>]]
vim.cmd [[nnoremap <Leader>bc :BufferLinePickClose<CR>]]
vim.cmd [[nnoremap <silent> <Leader>b[ :BufferLineCloseLeft<CR>]]
vim.cmd [[nnoremap <silent> <Leader>b] :BufferLineCloseRight<CR>]]

-----------------
--- nvim-tree ---
-----------------
keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap=true, silent=true})
keymap('n', '<Leader>nf', ':NvimTreeFindFile<CR>', {noremap=true, silent=true})
keymap('n', '<Leader>nr', ':NvimTreeRefresh<CR>', {noremap=true, silent=true})

---------------------------
--- zenmode && twilight ---
---------------------------
keymap('n', '<Leader>zz', ':ZenMode<CR>', {noremap=true})
keymap('n', '<Leader>zt', ':Twilight<CR>', {noremap=true})

----------------
--- hop.nvim ---
----------------
vim.cmd [[nnoremap <Leader><Leader>k <cmd>HopLine<CR>]]
vim.cmd [[nnoremap <Leader><Leader>j <cmd>HopLine<CR>]]
vim.cmd [[nnoremap <Leader><Leader>l <cmd>HopWord<CR>]]
vim.cmd [[nnoremap <Leader><Leader>h <cmd>HopWord<CR>]]
vim.cmd [[nnoremap <Leader><Leader>s <cmd>HopChar2<CR>]]


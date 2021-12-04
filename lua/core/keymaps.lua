local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, nowait = true}

------------------------
-- TODO: 使用 which-key 管理
------------------------

-- 快速保存和关闭
--keymap('', '<leader>w', ':w!<CR>', opts)
--keymap('', '<leader>q', ':q!<CR>', opts)
-- 关闭高亮
--keymap('', '<leader><enter>', ':noh<CR>', opts)
-- Y 复制到行尾
keymap('n', 'Y', 'y$', opts)
-- Y 复制到剪贴板（visual mode）
keymap('v', 'Y', '"+y', opts)
-- 移动到行首/行尾
--keymap('n', 'H', '^', opts)
--keymap('n', 'L', '$', opts)
-- 连续缩进
--keymap('v', '<', '<gv', opts)
--keymap('v', '>', '>gv', opts)
--keymap('v', '<Tab>', '<gv', opts)
--keymap('v', '<S-Tab>', '>gv', opts)
-- repeat in visual mode
keymap('v', '.', ':normal .<CR>', opts)
-- 交换上下行
--keymap('n', '<M-j>', 'mz:m+<cr>`z', opts)
--keymap('n', '<M-k>', 'mz:m-2<cr>`z', opts)
-- keymap('v', '<M-j>', ":m'>+<cr>`<my`>mzgv`yo`z", opts)
-- keymap('v', '<M-k>', ":m'<-2<cr>`>my`<mzgv`yo`z", opts)

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
vim.cmd [[nnoremap <silent> <leader>fp :Telescope projects<cr>]]
-- neoclip
vim.cmd [[nnoremap <silent> <leader>fc :Telescope neoclip<cr>]]

------------------
--- bufferline ---
------------------
vim.cmd [[nnoremap <silent> [b :BufferLineCyclePrev<CR>]]
vim.cmd [[nnoremap <silent> ]b :BufferLineCycleNext<CR>]]
--vim.cmd [[nnoremap <Leader>bb :BufferLinePick<CR>]]
--vim.cmd [[nnoremap <Leader>bc :BufferLinePickClose<CR>]]
--vim.cmd [[nnoremap <silent> <Leader>b[ :BufferLineCloseLeft<CR>]]
--vim.cmd [[nnoremap <silent> <Leader>b] :BufferLineCloseRight<CR>]]

-----------------
--- nvim-tree ---
-----------------
keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap=true, silent=true})
keymap('n', '<Leader>nf', ':NvimTreeFindFile<CR>', {noremap=true, silent=true})
keymap('n', '<Leader>nr', ':NvimTreeRefresh<CR>', {noremap=true, silent=true})

---------------------------
--- zenmode && twilight ---
---------------------------
-- keymap('n', '<Leader>zz', ':ZenMode<CR>', {noremap=true})
-- keymap('n', '<Leader>zt', ':Twilight<CR>', {noremap=true})


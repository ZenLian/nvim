local augroup = function(name)
  vim.api.nvim_create_augroup(name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

local group = augroup('core')
-- return to last edit position
autocmd({ 'BufReadPost' }, {
  -- command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
  group = group,
  callback = function()
    local pos = vim.fn.line([['"]])
    if pos > 1 and pos <= vim.fn.line('$') then
      vim.cmd([[normal! g'"]])
    end
  end,
})

-- highlight on yank
autocmd({ 'TextYankPost' }, {
  -- command = [[ silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150} ]],
  group = group,
  callback = function()
    vim.highlight.on_yank() -- { higroup = 'Visual', timeout = 250 }
  end,
})

-- hide cursorline for unfocused window
local cursorline_pattern = {
  '!TelescopePrompt',
  '!DressingInput',
}

autocmd({ 'WinEnter' }, {
  group = group,
  pattern = cursorline_pattern,
  callback = function()
    vim.wo.cursorline = true
  end,
})
autocmd({ 'WinLeave' }, {
  group = group,
  pattern = cursorline_pattern,
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- equalize window when vim window resized
autocmd({ 'VimResized' }, {
  group = group,
  -- command = [[tabdo wincmd =]]
  command = [[wincmd =]],
})

-- windows to close with "q"
-- vim.cmd([[autocmd FileType help,startuptime,qf,lspinfo,notify,tsplayground nnoremap <buffer><silent> q :close<CR>]])
-- vim.cmd([[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]])
autocmd({ 'FileType' }, {
  group = group,
  pattern = {
    'help',
    'startuptime',
    'qf',
    'lspinfo',
    'notify',
    'tsplayground',
    'null-ls-info',
    'checkhealth',
  },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})

-- markdown spell on
-- vim.cmd([[autocmd FileType markdown setlocal spell]])

local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd

local NAME = 'config.autocmds'
local group = vim.api.nvim_create_augroup(NAME, { clear = true })

autocmd({ 'BufWinEnter' }, {
  group = group,
  desc = 'Return to last position',
  callback = function()
    -- local pos = vim.fn.line([['"]])
    -- if pos > 1 and pos <= vim.fn.line('$') then vim.cmd([[normal! g'"]]) end

    -- ref to https://github.com/ethanholz/nvim-lastplace
    if fn.line('.') > 1 then
      return
    end
    local last_line = fn.line([['"]])
    local buff_last_line = fn.line('$')
    local window_last_line = fn.line('w$')
    local window_first_line = fn.line('w0')
    -- If the last line is set and the less than the last line in the buffer
    if last_line > 0 and last_line <= buff_last_line then
      -- Check if the last line of the buffer is the same as the window
      if window_last_line == buff_last_line then
        -- Set line to last line edited
        vim.cmd([[normal! g`"]])
      -- Try to center
      elseif buff_last_line - last_line > ((window_last_line - window_first_line) / 2) - 1 then
        vim.cmd([[normal! g`"zz]])
      else
        vim.cmd([[normal! G'"<c-e>]])
      end
    end
    if fn.foldclosed('.') ~= -1 then
      vim.cmd([[normal! zvzz]])
    end
  end,
})

-- highlight on yank (handled by yanky.nvim)
-- autocmd({ 'TextYankPost' }, {
--   -- command = [[ silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150} ]],
--   group = group,
--   callback = function()
--     vim.highlight.on_yank() -- { higroup = 'Visual', timeout = 250 }
--   end,
-- })

-- hide cursorline for unfocused window
local cursorline_ignore_ft = {
  'TelescopePrompt',
  'DressingInput',
  '',
}

autocmd({ 'WinEnter', 'WinLeave' }, {
  group = group,
  desc = 'Hide cursorline for unfocused windows',
  callback = function(args)
    if vim.tbl_contains(cursorline_ignore_ft, vim.bo.filetype) then
      return
    end
    if args.event == 'WinLeave' then
      vim.wo.cursorline = false
    else -- 'WinEnter'
      vim.wo.cursorline = true
    end
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
  desc = 'Filetypes to close with "q"',
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

local fn = vim.fn
local util = require('util')

util.augroup {
  ['vimrc.lastedit'] = {
    -- https://github.com/ethanholz/nvim-lastplace
    desc = 'Back to where you leave',
    event = { 'BufWinEnter' },
    callback = function()
      -- local pos = vim.fn.line([['"]])
      -- if pos > 1 and pos <= vim.fn.line('$') then vim.cmd([[normal! g'"]]) end

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
    end,
  },
  ['vimrc.equalwin'] = {
    desc = 'Equalize window',
    event = 'VimResized',
    command = [[wincmd =]],
  },
  ['vimrc.smartclose'] = {
    {
      desc = 'Filetypes to close with "q"',
      event = { 'FileType' },
      pattern = {
        'help',
        'startuptime',
        'qf',
        'lspinfo',
        'notify',
        'tsplayground',
        'null-ls-info',
        'checkhealth',
        'drex',
      },
      command = [[nnoremap <buffer><silent> q :close<CR>]],
    },
    {
      desc = 'Auto close corresponding loclist',
      event = { 'QuitPre' },
      pattern = '*',
      nested = true,
      callback = function()
        if vim.bo.filetype ~= 'qf' then
          vim.cmd('silent! lclose')
        end
      end,
    },
  },
  ['vimrc.smartopen'] = {
    -- https://vim.fandom.com/wiki/Use_gf_to_open_a_file_via_its_URL
    desc = "use gf to open a file via it's URL",
    event = { 'BufReadCmd' },
    pattern = { 'file:///*' },
    nested = true,
    callback = function(args)
      vim.cmd.bdelete { bang = true }
      vim.cmd.edit(vim.uri_to_fname(args.file))
    end,
  },
  -- NOTE: now handled by yanky.nvim
  -- ['vimrc.highlightYank'] = {
  --   {
  --     desc = 'highlight on yank',
  --     event = { 'TextYankPost' },
  --     callback = function()
  --       vim.highlight.on_yank {
  --         timeout = 250,
  --         on_visual = false,
  --         higroup = 'Visual',
  --       }
  --     end,
  --   },
  -- },
  ['vimrc.markdown'] = {
    desc = 'markdown file',
    event = { 'FileType' },
    pattern = { 'markdown' },
    callback = function()
      vim.wo.spell = true
    end,
  },
}

-- markdown spell on
-- vim.cmd([[autocmd FileType markdown setlocal spell]])
--

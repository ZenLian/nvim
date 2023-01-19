local fn = vim.fn
local util = require('util')

local groups = {
  ['vimrc.lastedit'] = {
    -- https://github.com/ethanholz/nvim-lastplace
    desc = 'Back to where you leave',
    event = { 'BufWinEnter' },
    callback = function()
      -- exclude filetypes
      if vim.tbl_contains({ 'gitcommit' }, vim.bo.filetype) then
        return
      end
      -- we're not at beginning
      --
      if fn.line('.') > 1 then
        return
      end
      -- coming back!
      local pos = vim.fn.line([['"]])
      if pos > 1 and pos <= vim.fn.line('$') then
        vim.cmd([[normal! g'"]])
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
        'Neogit*',
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
  ['vimrc.highlightYank'] = {
    {
      desc = 'highlight on yank',
      event = { 'TextYankPost' },
      callback = function()
        vim.highlight.on_yank {
          timeout = 200,
          -- on_visual = false,
          higroup = 'OnYank',
          -- higroup = 'IncSearch',
        }
      end,
    },
  },
  ['vimrc.markdown'] = {
    {
      desc = 'Entering markdown',
      event = { 'BufWinEnter' },
      pattern = { '*.md' },
      callback = function()
        vim.wo.spell = true
      end,
    },
    {
      desc = 'Leaving markdown',
      event = { 'BufWinLeave' },
      pattern = { '*.md' },
      callback = function()
        vim.wo.spell = false
      end,
    },
  },
}

return {
  setup = function()
    util.augroup(groups)
  end,
}

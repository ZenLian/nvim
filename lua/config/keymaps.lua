local util = require('util')

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

util.keymaps {
  -- Save
  ['<C-s>'] = '<cmd>w<CR>',
  -- Quit
  ['<C-q>'] = '<cmd>qa<CR>',

  -- window focus
  ['<C-h>'] = '<C-w>h',
  ['<C-j>'] = '<C-w>j',
  ['<C-k>'] = '<C-w>k',
  ['<C-l>'] = '<C-w>l',

  -- Resize window
  ['<C-Up>'] = '<cmd>resize +2<CR>',
  ['<C-Down>'] = '<cmd>resize -2<CR>',
  ['<C-Left>'] = '<cmd>vertical resize -2<CR>',
  ['<C-Right>'] = '<cmd>vertical resize +2<CR>',

  -- Clear search with <esc>
  ['<esc>'] = '<cmd>noh<cr>',
}
-- TODO:
-- Close buffer
-- keymap('', 'Q', '<cmd>lua require("mini.bufremove").delete()<CR>')

-- Move lines
-- https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
util.keymaps({
  ['<A-j>'] = ':m .+1<CR>==',
  ['<A-k>'] = ':m .-2<CR>==',
}, { mode = 'n' })
util.keymaps({
  ['<A-j>'] = ":m '>+1<CR>gv=gv",
  ['<A-k>'] = ":m '<-2<CR>gv=gv",
}, { mode = 'v' })
util.keymaps({
  ['<A-j>'] = '<Esc>:m .+1<CR>==gi',
  ['<A-k>'] = '<Esc>:m .-2<CR>==gi',
}, { mode = 'i' })

-- Better indent
util.keymaps({
  -- Indent without leaving Visual Mode
  ['<'] = '<gv',
  ['>'] = '>gv',
  -- Indent with tab in Visual Mode
  ['<S-Tab>'] = '<gv',
  ['<Tab>'] = '>gv',
}, { mode = 'v' })

-- saner copy/paste atcion
-- Yank to end of line, consistence with D/C
util.keymaps({ ['Y'] = 'y$' }, { mode = 'n' })
-- Yank to system clipboard
util.keymaps({ ['Y'] = '"+y' }, { mode = 'v', remap = true })
-- Paste block
util.keymaps {
  ['[p'] = '<cmd>pu<cr>',
  [']p'] = '<cmd>pu!<cr>',
}
-- Safe paste
-- keymap('v', 'p', '"_dp')

-- Saner n/N, always search forward/backward
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
util.keymaps({
  ['n'] = "'Nn'[v:searchforward]",
  ['N'] = "'nN'[v:searchforward]",
}, { mode = { 'n', 'v', 'o' }, expr = true })

-- '[' and ']'
util.keymaps {
  [']'] = {
    c = { '<cmd>cnext<cr>', desc = 'Next quickfix' },
    t = { '<cmd>tabnext<cr>', desc = 'Next tab' },
  },
  ['['] = {
    c = { '<cmd>cprev<cr>', desc = 'Previous quickfix' },
    t = { '<cmd>tabprev<cr>', desc = 'Previous tab' },
  },
}

util.keymaps {
  ['<Leader>'] = {
    ['gl'] = {
      function()
        util.float_terminal('lazygit')
      end,
      desc = 'LazyGit',
    },
    ['pp'] = { '<cmd>Lazy<cr>', desc = 'Plugins' },
  },
}

-- TODO
local function register_leader()
  local leader = {
    q = {
      name = 'quit',
      q = { '<cmd>qa!<cr>', 'Quit' },
      w = { '<cmd>wqa<cr>', 'Save all and quit' },
      t = { '<cmd>tabclose<cr>', 'Close tab' },
    },
    x = {
      name = 'trouble',
      t = { '<cmd>TodoTrouble<cr>', 'Todos' },
    },
    ['\\'] = {
      name = 'terminal',
      s = { '<cmd>ToggleTermSendCurrentLine<cr>', 'Send line' },
    },
    [';'] = { '<cmd>AerialToggle<CR>', 'Outline' },
    ['<Leader>'] = { '<cmd>Telescope resume<CR>', 'Telescope Resume' },
  }

  local leader_visual = {
    ['\\'] = {
      name = 'terminal',
      s = { '<cmd>ToggleTermSendVisualSelection<cr>', 'Send selected' },
    },
  }
end

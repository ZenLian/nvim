local util = require('util')

local function map(mode, lhs, rhs, opts)
  local options = {
    -- noremap = true, -- default in vim.keymap.set
    silent = true,
  }
  options = vim.tbl_deep_extend('force', options, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Move to window
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Resize window
map('n', '<S-Up>', ':resize +2<CR>')
map('n', '<S-Down>', ':resize -2<CR>')
map('n', '<S-Left>', ':vertical resize -2<CR>')
map('n', '<S-Right>', ':vertical resize +2<CR>')

-- Move lines
-- https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
map('n', '<A-j>', ':m .+1<CR>==')
map('n', '<A-k>', ':m .-2<CR>==')
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')

-- Indent without leaving Visual Mode
map('v', '<', '<gv')
map('v', '>', '>gv')
-- Indent with tab in Visual Mode
map('v', '<S-Tab>', '<gv')
map('v', '<Tab>', '>gv')

-- Clear search with <esc>
map('n', '<esc>', ':noh<cr>')

-- Paste block
-- map('n', ']p', ':pu<cr>')
-- map('n', '[p', ':pu!<cr>')
-- Yank to end of line, consistence with D/C
map('n', 'Y', 'y$')
-- Yank to system clipboard
map('v', 'Y', '"+y')
-- H = { "^", "Start of line" },
-- L = { "$", "End of line" },

-- n/N always search forward/backward
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ 'n', 'v', 'o' }, 'n', "'Nn'[v:searchforward]", { expr = true })
map({ 'n', 'v', 'o' }, 'N', "'nN'[v:searchforward]", { expr = true })

-- tabs
map('n', '[t', '<cmd>tabn<CR>')
map('n', ']t', '<cmd>tabp<CR>')

-- save
map('n', '<C-s>', '<cmd>w<CR>')

--
-- plugins
--
map('n', '[b', '<cmd>BufferLineCyclePrev<CR>')
map('n', ']b', '<cmd>BufferLineCycleNext<CR>')
map('n', '<A-,>', '<cmd>BufferLineMovePrev<CR>')
map('n', '<A-.>', '<cmd>BufferLineMoveNext<CR>')
map('n', '<C-e>', '<cmd>Neotree<CR>')
map('n', '<C-f>', '<cmd>Telescope current_buffer_fuzzy_find<CR>')

-- yanky.nvim
vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
vim.keymap.set('n', '<A-]>', '<Plug>(YankyCycleForward)')
vim.keymap.set('n', '<A-[>', '<Plug>(YankyCycleBackward)')
vim.keymap.set('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)')
vim.keymap.set('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)')
vim.keymap.set('n', ']P', '<Plug>(YankyPutIndentAfterLinewise)')
vim.keymap.set('n', '[P', '<Plug>(YankyPutIndentBeforeLinewise)')
vim.keymap.set('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)')
vim.keymap.set('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)')
vim.keymap.set('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)')
vim.keymap.set('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)')
vim.keymap.set('n', '=p', '<Plug>(YankyPutAfterFilter)')
vim.keymap.set('n', '=P', '<Plug>(YankyPutBeforeFilter)')

map('n', '<C-p>', function()
  require('plugins.telescope').project_files()
end)

--
-- leader keymaps
--
local leader = {
  b = {
    name = 'buffer',
    b = { '<cmd>e #<CR>', 'Last buffer' },
    d = { '<cmd>bd<CR>', 'Delete buffer' },
    g = { '<cmd>BufferLinePick<CR>', 'Goto buffer' },
    p = { '<cmd>BufferLineTogglePin<CR>', 'Pin/Unpin buffer' },
    c = { '<cmd>BufferLinePickClose<CR>', 'Pick Close buffer+' },
    -- ['-'] = { 'Close other buffers' },
    ['['] = { '<cmd>BufferLineCloseLeft<CR>', 'Close left buffers' },
    [']'] = { '<cmd>BufferLineCloseRight<CR>', 'Close right buffers' },
    s = {
      name = 'sort',
      n = { '<cmd>BufferLineSortByTabs<CR>', 'Sort by name' },
      t = { '<cmd>BufferLineSortByExtension<CR>', 'Sort by type' },
      d = { '<cmd>BufferLineSortByDirectory<CR>', 'Sort by directory' },
    },
  },
  e = { '<cmd>Neotree toggle=true<CR>', 'toggle neotree' },
  f = {
    name = 'files',
    f = { '<cmd>Telescope find_files<CR>', 'Find files' },
    r = { '<cmd>Telescope oldfiles<CR>', 'Recent files' },
    h = { '<cmd>Telescope frecency<CR>', 'Frecency files' },
    e = { '<cmd>Telescope file_browser<CR>', 'File Explorer' },
  },
  g = {
    name = 'git',
    g = { '<cmd>Neogit<CR>', 'Neogit' },
    l = {
      function()
        util.float_terminal('lazygit')
      end,
      'LazyGit',
    },
    b = { '<cmd>Telescope git_branches<CR>', 'Branches' },
    c = { '<cmd>Telescope git_commits<CR>', 'Commits' },
    s = { '<cmd>Telescope git_status<CR>', 'Status' },
    d = { '<cmd>DiffviewOpen<cr>', 'DiffView' },
    h = {
      -- defined by gitsigns
      name = 'hunk',
      s = 'Stage hunk',
      S = 'Stage file',
      u = 'Unstage hunk',
      U = 'Unstage file',
      r = 'Reset hunk',
      R = 'Reset file',
      p = 'Preview hunk',
      b = 'Blame line',
    },
  },
  i = {
    name = 'insert',
    s = { '<cmd>Telescope symbols<CR>', 'Symbols' },
    y = { '<cmd>YankyRingHistory<CR>', 'Yank History' },
  },
  o = {
    name = 'open',
    g = { '<cmd>Glow<CR>', 'Glow' }, -- markdown preview
    p = { '<cmd>PeekToggle<CR>', 'Live preview' },
  },
  p = {
    name = 'packer',
    p = { '<cmd>PackerSync<CR>', 'Packer Sync' },
    s = { '<cmd>PackerStatus<CR>', 'Packer Status' },
    c = { '<cmd>PackerCompile<CR>', 'Packer Complile' },
  },
  q = {
    name = 'quit',
    q = { '<cmd>qa<cr>', 'Quit' },
    ['!'] = { '<cmd>qa!<cr>', 'Force quit' },
    w = { '<cmd>wqa<cr>', 'Save all and quit' },
  },
  s = {
    name = 'search',
    b = { '<cmd>Telescope buffers<CR>', 'Buffers' },
    g = { '<cmd>Telescope live_grep<CR>', 'Grep' },
    w = { '<cmd>Telescope grep_string<CR>', 'Current word' },
    z = { '<cmd>Telescope current_buffer_fuzzy_find<CR>', 'Fuzzy Find in Buffer' },
    ['/'] = { '<cmd>Telescope help_tags<CR>', 'Help Tags' },
    ["'"] = { '<cmd>Telescope notify<CR>', 'Notifications' },
  },
  t = {
    name = 'tab',
    c = { '<cmd>tabclose<CR>', 'Close tab' },
  },
  w = {
    name = 'workspace',
    w = { '<cmd>Telescope persisted<CR>', 'List' },
    t = { '<cmd>lua require("persisted").toggle()<CR>', 'Toggle' },
    s = { '<cmd>lua require("persisted").save()<CR>', 'Save' },
  },
  x = {
    name = 'trouble',
    x = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Diagnostics' },
    t = { '<cmd>TodoTrouble<cr>', 'Todos' },
  },
  z = {
    name = 'zen',
    z = { '<cmd>ZenMode<CR>', 'ZenMode' },
    r = { "<cmd>lua require('zen-mode').reset()<cr>", 'Reset ZenMode' },
    t = { '<cmd>Twilight<CR>', 'Twilight' },
  },
  ['\\'] = {
    name = 'terminal',
    s = { '<cmd>ToggleTermSendCurrentLine<cr>', 'Send line' },
  },
  ['/'] = {
    name = 'toggle',
    f = {
      require('plugins.lspconfig.formatting').toggle,
      'Format on save',
    },
    s = {
      function()
        util.toggle('spell', false)
      end,
      'Spelling',
    },
    w = {
      function()
        util.toggle('wrap', false)
      end,
      'Word wrap',
    },
    n = {
      function()
        util.toggle('relativenumber', true)
        util.toggle('number', false)
      end,
      'Line Numbers',
    },
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

local function register()
  local wk = require('which-key')
  wk.register(leader, { prefix = '<Leader>' })
  wk.register(leader_visual, { prefix = '<Leader>', mode = 'v' })
end

pcall(register)

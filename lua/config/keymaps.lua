local util = require('util')
local _, wk = pcall(require, 'which-key')
local M = {}

local function map(mode, lhs, rhs, opts)
  local options = {
    -- noremap = true, -- default in vim.keymap.set
    silent = true,
  }
  options = vim.tbl_deep_extend('force', options, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

local function register_basic()
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
  -- save
  map('n', '<C-s>', '<cmd>w<CR>')

  -- plugins
  map('n', '<A-,>', '<cmd>BufferLineMovePrev<CR>')
  map('n', '<A-.>', '<cmd>BufferLineMoveNext<CR>')
  map('n', '<C-e>', '<cmd>Neotree<CR>')
  map('n', '<C-f>', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
  -- treehopper
  -- FIXME: vim.keymap.set don't work as expected
  vim.api.nvim_set_keymap('x', 'm', ':lua require("tsht").nodes()<CR>', { silent = true, noremap = true })
  vim.api.nvim_set_keymap('o', 'm', ':<C-U>lua require("tsht").nodes()<CR>', { silent = true })

  -- telescope
  map('n', '<C-p>', function()
    require('plugins.telescope').project_files()
  end)
end

local function register_next_prev()
  --
  -- next/previous
  --
  local next = {
    name = 'Next',
    b = { '<cmd>lua require("bufferline").cycle(1)<cr>', 'Next buffer' },
    -- B = { ':bfirst' },
    B = { '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>', 'First buffer' },
    d = 'Next diagnostic',
    e = 'Next error',
    t = { ':tabn<cr>', 'Next tab page' },
  }

  local prev = {
    name = 'Previous',
    b = { '<cmd>lua require("bufferline").cycle(-1)<cr>', 'Previous buffer' },
    -- B = { ':blast' },
    B = { '<cmd>lua require("bufferline").go_to_buffer(-1, true)<cr>', 'Last buffer' },
    d = 'Previous diagnostic',
    e = 'Previous error',
    t = { ':tabp<cr>', 'Previous tab page' },
  }
  wk.register(next, { prefix = ']' })
  wk.register(prev, { prefix = '[' })
end

local function register_toggles()
  -- Params: ~
  --   specs
  --     {name} vim option name
  --     {desc} description
  --     {opts} additional opts for util.toggle
  local function make_toggles(specs)
    local keys = {
      name = 'Toggles',
    }
    for key, v in pairs(specs) do
      keys[key] = {}
      local entry = keys[key]
      entry.name = v.name
      local name = entry.name
      entry[key] = {
        function()
          util.toggle(name, v.opts)
        end,
        'Toggle ' .. name,
      }
      entry['['] = {
        function()
          util.toggle(name, util.tbl_merge(v.opts, { value = true }))
        end,
        'Toggle ' .. name .. ' on',
      }
      entry[']'] = {
        function()
          util.toggle(name, util.tbl_merge(v.opts, { value = false }))
        end,
        'Toggle ' .. name .. ' off',
      }
    end
    return keys
  end

  local toggles = make_toggles {
    s = { name = 'spell', desc = 'spell check' },
    w = { name = 'wrap', desc = 'word wrap' },

    -- TODO: merge these two
    n = { name = 'relativenumber', desc = 'relative line number' },
    N = { name = 'number', desc = 'line number' },
  }

  toggles.f = {
    name = 'auto format',
    f = {
      '<cmd>lua require("plugins.lspconfig.formatting").toggle()<cr>',
      'Toggle auto format',
    },
    ['['] = {
      '<cmd>lua require("plugins.lspconfig.formatting").toggle(true)<cr>',
      'Toggle auto format on',
    },
    [']'] = {
      '<cmd>lua require("plugins.lspconfig.formatting").toggle(false)<cr>',
      'Toggle auto format off',
    },
  }

  require('which-key').register(toggles, { prefix = '<Leader>/' })
end

-- yanky.nvim
local function register_yanky()
  map({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
  map({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
  map({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
  map({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
  map({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
  map('n', '<A-]>', '<Plug>(YankyCycleForward)')
  map('n', '<A-[>', '<Plug>(YankyCycleBackward)')
  map('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)')
  map('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)')
  map('n', ']P', '<Plug>(YankyPutIndentAfterLinewise)')
  map('n', '[P', '<Plug>(YankyPutIndentBeforeLinewise)')
  map('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)')
  map('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)')
  map('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)')
  map('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)')
  map('n', '=p', '<Plug>(YankyPutAfterFilter)')
  map('n', '=P', '<Plug>(YankyPutBeforeFilter)')
end

function M.register_gitsigns(bufnr)
  local whichkey = require('which-key')
  -- <Leader>g
  whichkey.register({
    name = 'git',
    D = { '<cmd>lua require("gitsigns").diffthis()<CR>', 'Diff index' },
    p = { '<cmd>lua require("gitsigns").preview_hunk_inline<CR>', 'Preview inline' },
    q = { '<cmd>lua require("gitsigns").setqflist(0)<CR>', 'Send to quickfix window' },
    h = {
      -- defined by gitsigns
      name = 'hunk',
      b = { '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', 'Blame line' },
      s = { '<cmd>lua require"gitsigns".stage_hunk()<CR>', 'Stage hunk' },
      S = { '<cmd>lua require"gitsigns".stage_buffer()<CR>', 'Stage file' },
      u = { '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', 'Unstage hunk' },
      U = { '<cmd>lua require"gitsigns".reset_buffer_index()<CR>', 'Unstage file' },
      r = { '<cmd>lua require"gitsigns".reset_hunk()<CR>', 'Reset hunk' },
      R = { '<cmd>lua require"gitsigns".reset_buffer()<CR>', 'Reset file' },
      p = { '<cmd>lua require("gitsigns").preview_hunk_inline<CR>', 'Preview inline' },
      P = { '<cmd>lua require("gitsigns").preview_hunk<CR>', 'Preview' },
    },
  }, { prefix = '<Leader>g', buffer = bufnr })
  -- <Leader>g Visual
  whichkey.register({
    name = 'git',
    h = {
      -- defined by gitsigns
      name = 'hunk',
      r = { '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'Reset hunk' },
      s = { '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'Stage hunk' },
    },
  }, { prefix = '<Leader>g', mode = 'v', buffer = bufnr })
  -- Next/Previous hunk
  whichkey.register({
    ['[g'] = {
      "&diff ? ']h' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
      'Previous hunk',
      expr = true,
    },
    [']g'] = {
      "&diff ? ']h' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
      'Next hunk',
      expr = true,
    },
  }, { buffer = bufnr })
  -- Text objects
  whichkey.register({
    ['ig'] = { '<cmd>lua require("gitsigns.actions").selecte_hunk()<CR>', 'a hunk' },
    ['ag'] = { '<cmd>lua require("gitsigns.actions").selecte_hunk()<CR>', 'a hunk' },
  }, { mode = { 'o', 'x' }, buffer = bufnr })
end

local function register_leader()
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
    e = { '<cmd>Neotree toggle=true<CR>', 'Toggle neotree' },
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
    [';'] = { '<cmd>AerialToggle<CR>', 'Outline' },
    ['<Leader>'] = { '<cmd>Telescope resume<CR>', 'Telescope Resume' },
  }

  local leader_visual = {
    ['\\'] = {
      name = 'terminal',
      s = { '<cmd>ToggleTermSendVisualSelection<cr>', 'Send selected' },
    },
  }
  wk.register(leader, { prefix = '<Leader>' })
  wk.register(leader_visual, { prefix = '<Leader>', mode = 'v' })
end

function M.init()
  register_basic()
  register_next_prev()
  register_toggles()
  register_yanky()
  register_leader()
end

-- pcall(M.init)
M.init()

return M

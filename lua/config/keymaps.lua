local util = require('util')
local _, wk = pcall(require, 'which-key')
local M = {}

local function keymap(mode, lhs, rhs, opts)
  opts = util.tbl_merge({ noremap = true, silent = true }, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function register_basic()
  -- Save
  keymap('', '<C-s>', '<cmd>w<CR>')
  -- Quit
  keymap('', '<C-q>', '<cmd>qa<CR>')
  -- Close buffer
  keymap('', 'Q', '<cmd>lua require("mini.bufremove").delete()<CR>')

  -- Move to window
  keymap('n', '<C-h>', '<C-w>h')
  keymap('n', '<C-j>', '<C-w>j')
  keymap('n', '<C-k>', '<C-w>k')
  keymap('n', '<C-l>', '<C-w>l')
  -- Resize window
  keymap('n', '<C-Up>', ':resize +2<CR>')
  keymap('n', '<C-Down>', ':resize -2<CR>')
  keymap('n', '<C-Left>', ':vertical resize -2<CR>')
  keymap('n', '<C-Right>', ':vertical resize +2<CR>')
  -- Move lines
  -- https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
  keymap('n', '<A-j>', ':m .+1<CR>==')
  keymap('n', '<A-k>', ':m .-2<CR>==')
  keymap('v', '<A-j>', ":m '>+1<CR>gv=gv")
  keymap('v', '<A-k>', ":m '<-2<CR>gv=gv")
  keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
  keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
  -- Indent without leaving Visual Mode
  keymap('v', '<', '<gv')
  keymap('v', '>', '>gv')
  -- Indent with tab in Visual Mode
  keymap('v', '<S-Tab>', '<gv')
  keymap('v', '<Tab>', '>gv')
  -- Clear search with <esc>
  keymap('n', '<esc>', ':noh<cr>')

  -- Paste block
  -- map('n', ']p', ':pu<cr>')
  -- map('n', '[p', ':pu!<cr>')
  -- Safe paste
  -- keymap('v', 'p', '"_dp')
  -- Yank to end of line, consistence with D/C
  keymap('n', 'Y', 'y$')
  -- Yank to system clipboard
  keymap('v', 'Y', '"+y', { noremap = false })

  -- n/N always search forward/backward
  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  keymap({ 'n', 'v', 'o' }, 'n', "'Nn'[v:searchforward]", { expr = true })
  keymap({ 'n', 'v', 'o' }, 'N', "'nN'[v:searchforward]", { expr = true })

  -- plugins
  keymap('n', '<C-e>', '<cmd>Neotree<CR>')
  keymap('n', '<C-f>', '<cmd>Telescope current_buffer_fuzzy_find<CR>')

  -- bufferline
  keymap('n', 'H', '<cmd>lua require("bufferline").cycle(-1)<CR>', { desc = 'Previous buffer' })
  keymap('n', 'L', '<cmd>lua require("bufferline").cycle(1)<CR>', { desc = 'Next buffer' })
  keymap('n', '<A-,>', '<cmd>BufferLineMovePrev<CR>')
  keymap('n', '<A-.>', '<cmd>BufferLineMoveNext<CR>')

  -- treehopper
  -- FIXME: vim.keymap.set don't work as expected
  vim.api.nvim_set_keymap('x', 'm', ':lua require("tsht").nodes()<CR>', { silent = true, noremap = true })
  vim.api.nvim_set_keymap('o', 'm', ':<C-U>lua require("tsht").nodes()<CR>', { silent = true })

  -- telescope
  keymap('n', '<C-p>', function()
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
  keymap({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
  keymap({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
  keymap({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
  keymap({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
  keymap({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
  keymap('n', '<A-]>', '<Plug>(YankyCycleForward)')
  keymap('n', '<A-[>', '<Plug>(YankyCycleBackward)')
  keymap('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)')
  keymap('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)')
  keymap('n', ']P', '<Plug>(YankyPutIndentAfterLinewise)')
  keymap('n', '[P', '<Plug>(YankyPutIndentBeforeLinewise)')
  keymap('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)')
  keymap('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)')
  keymap('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)')
  keymap('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)')
  keymap('n', '=p', '<Plug>(YankyPutAfterFilter)')
  keymap('n', '=P', '<Plug>(YankyPutBeforeFilter)')
end

function M.register_gitsigns(bufnr)
  local whichkey = require('which-key')
  -- <Leader>g
  whichkey.register({
    name = 'git',
    D = { '<cmd>lua require("gitsigns").diffthis()<CR>', 'Diff index' },
    p = { '<cmd>lua require("gitsigns").preview_hunk_inline()<CR>', 'Preview inline' },
    P = { '<cmd>lua require("gitsigns").preview_hunk()<CR>', 'Preview' },
    q = { '<cmd>lua require("gitsigns").setqflist(0)<CR>', 'Send to quickfix window' },
    b = { '<cmd>lua require("gitsigns").blame_line{full=true}<CR>', 'Git blame' },
    h = {
      -- defined by gitsigns
      name = 'hunk',
      s = { '<cmd>lua require("gitsigns").stage_hunk()<CR>', 'Stage hunk' },
      S = { '<cmd>lua require("gitsigns").stage_buffer()<CR>', 'Stage file' },
      u = { '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', 'Unstage hunk' },
      U = { '<cmd>lua require("gitsigns").reset_buffer_index()<CR>', 'Unstage file' },
      r = { '<cmd>lua require("gitsigns").reset_hunk()<CR>', 'Reset hunk' },
      R = { '<cmd>lua require("gitsigns").reset_buffer()<CR>', 'Reset file' },
    },
  }, { prefix = '<Leader>g', buffer = bufnr })
  -- <Leader>g Visual
  whichkey.register({
    name = 'git',
    h = {
      -- defined by gitsigns
      name = 'hunk',
      r = { '<cmd>lua require"gitsigns.actions".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'Reset hunk' },
      s = { '<cmd>lua require"gitsigns.actions".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'Stage hunk' },
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
    ['ig'] = { '<cmd>lua require("gitsigns.actions").select_hunk()<CR>', 'a hunk' },
    ['ag'] = { '<cmd>lua require("gitsigns.actions").select_hunk()<CR>', 'a hunk' },
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
      -- d = { '<cmd>bd<CR>', 'Delete buffer' },
      d = { '<cmd>lua require("mini.bufremove").delete()<CR>', 'Delete buffer' },
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
      name = 'find files/text',
      f = { '<cmd>Telescope find_files<CR>', 'Find files' },
      r = { '<cmd>Telescope oldfiles<CR>', 'Recent files' },
      h = { '<cmd>Telescope frecency<CR>', 'Frecency files' },
      e = { '<cmd>Telescope file_browser<CR>', 'File Explorer' },
      b = { '<cmd>Telescope buffers<CR>', 'Buffers' },
      g = { '<cmd>Telescope live_grep<CR>', 'Grep' },
      w = { '<cmd>Telescope grep_string<CR>', 'Current word' },
      z = { '<cmd>Telescope current_buffer_fuzzy_find<CR>', 'Fuzzy Find in Buffer' },
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
      B = { '<cmd>Telescope git_branches<CR>', 'Branches' },
      C = { '<cmd>Telescope git_commits<CR>', 'Commits' },
      s = { '<cmd>Telescope git_status<CR>', 'Status' },
      d = { '<cmd>DiffviewOpen<cr>', 'DiffView' },
    },
    o = {
      name = 'open',
      g = { '<cmd>Glow<CR>', 'Glow' }, -- markdown preview
      p = { '<cmd>PeekToggle<CR>', 'Live preview' },
    },
    p = {
      name = 'package management',
      p = { '<cmd>PackerStatus<CR>', 'Packer Status' },
      u = { '<cmd>PackerUpdate<CR>', 'Packer Update' },
      s = { '<cmd>PackerSync<CR>', 'Packer Sync' },
      c = { '<cmd>PackerCompile<CR>', 'Packer Complile' },
      l = { '<cmd>LspInfo<CR>', 'Lsp Info' },
      L = { '<cmd>LspInstall<CR>', 'Install lsp server' },
      n = { '<cmd>NullLsInfo<CR>', 'Null-ls Info' },
      N = { '<cmd>NullLsInstall<CR>', 'Install null-ls source' },
    },
    q = {
      name = 'quit',
      q = { '<cmd>qa!<cr>', 'Quit' },
      w = { '<cmd>wqa<cr>', 'Save all and quit' },
      t = { '<cmd>tabclose<cr>', 'Close tab' },
    },
    s = {
      name = 'search',
      h = { '<cmd>Telescope help_tags<CR>', 'Help Tags' },
      y = { '<cmd>YankyRingHistory<CR>', 'Yank History' },
      [';'] = { '<cmd>Telescope symbols<CR>', 'Symbols' },
      ["'"] = { '<cmd>Telescope notify<CR>', 'Notifications' },
    },
    w = {
      name = 'sessions',
      w = { '<cmd>lua MiniSessions.select("read", {})<CR>', 'Load Session+' },
      d = { '<cmd>lua MiniSessions.select("delete", {})<CR>', 'Delete Session+' },
      s = { '<cmd>lua MiniSessions.write(nil, {})<CR>', 'Save Session' },
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

pcall(M.init)

return M

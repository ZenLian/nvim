local spec = {
  'anuvyklack/hydra.nvim',
  event = 'VeryLazy',
}

local function scroll_widget()
  local hydra = require('hydra')

  hydra {
    name = 'Side scroll',
    mode = 'n',
    body = 'z',
    heads = {
      { 'h', '5zh' },
      { 'l', '5zl', { desc = '←/→' } },
      { 'H', 'zH' },
      { 'L', 'zL', { desc = 'half screen ←/→' } },
    },
  }
end

local function window_widget()
  local hydra = require('hydra')
  hydra {
    name = 'Resize window',
    mode = 'n',
    body = '<C-w>',
    heads = {
      -- { 'h', '<C-w>h' },
      -- { 'j', '<C-w>j' },
      -- { 'k', '<C-w>k' },
      -- { 'l', '<C-w>l', { desc = 'switch' } },
      -- { 'w', '<C-w>w', { desc = 'previous' } },
      { '<', '<C-w><' },
      { '>', '<C-w>>' },
      { '-', '<C-w>-' },
      { '+', '<C-w>+', { desc = 'resize' } },
      { '=', '<C-w>=', { desc = 'equalize' } },
      { '_', '<C-w>_' },
      { '|', '<C-w>|', { desc = 'maximize' } },
      { 's', '<C-w>s', { desc = 'split' } },
      { 'v', '<C-w>v', { desc = 'vsplit' } },
      { 'T', '<C-w>T', { desc = 'break out into tab' } },
      { 'x', '<C-w>x', { desc = 'swap' } },
      { 'q', '<C-w>q', { desc = 'quit' } },
    },
  }
end

local function option_menu()
  local hydra = require('hydra')
  local hint = [[
    ^^                  Options
    ^
    _v_ %{ve} virtual edit    ^^^ _d_ %{dgn} diagnostics
    _i_ %{list} invisible chars ^ _f_ %{fmt} format on save  ^
    _s_ %{spell} spell            _b_ %{blame} blame line
    _w_ %{wrap} wrap
    _c_ %{cul} cursor line
    _n_ %{nu} number
    _r_ %{rnu} relative number
    ^
                            _<Esc>_ or _q_ to quit
]]
  hydra {
    name = 'Options',
    config = {
      color = 'amaranth',
      invoke_on_body = true,
      hint = {
        border = 'single',
        position = 'middle',
        funcs = {
          ['dgn'] = function()
            return require('plugins.lspconfig.diagnostic').enable and '[x]' or '[ ]'
          end,
          ['fmt'] = function()
            return require('plugins.lspconfig.formatting').format_on_save and '[x]' or '[ ]'
          end,
          ['blame'] = function()
            return require('gitsigns.config').config.current_line_blame and '[x]' or '[ ]'
          end,
        },
      },
    },
    hint = hint,
    mode = { 'n', 'x' },
    body = '<leader>/',
    heads = {
      {
        'n',
        function()
          require('util').toggle('number', { silent = true })
        end,
        { desc = 'number' },
      },
      {
        'r',
        function()
          if vim.o.relativenumber == true then
            vim.o.relativenumber = false
          else
            vim.o.number = true
            vim.o.relativenumber = true
          end
        end,
        { desc = 'relativenumber' },
      },
      {
        'v',
        function()
          if vim.o.virtualedit == 'all' then
            vim.o.virtualedit = 'block'
          else
            vim.o.virtualedit = 'all'
          end
        end,
        { desc = 'virtualedit' },
      },
      {
        'i',
        function()
          require('util').toggle('list', { silent = true })
        end,
        { desc = 'show invisible' },
      },
      {
        's',
        function()
          require('util').toggle('spell', { silent = true })
        end,
        { exit = true, desc = 'spell' },
      },
      {
        'w',
        function()
          if not vim.o.wrap then
            vim.o.wrap = true
            -- Dealing with word wrap:
            -- If cursor is inside very long line in the file than wraps
            -- around several rows on the screen, then 'j' key moves you to
            -- the next line in the file, but not to the next row on the
            -- screen under your previous position as in other editors. These
            -- bindings fixes this.
            vim.keymap.set('n', 'k', function()
              return vim.v.count > 0 and 'k' or 'gk'
            end, { expr = true, desc = 'k or gk' })
            vim.keymap.set('n', 'j', function()
              return vim.v.count > 0 and 'j' or 'gj'
            end, { expr = true, desc = 'j or gj' })
          else
            vim.o.wrap = false
            vim.keymap.del('n', 'k')
            vim.keymap.del('n', 'j')
          end
        end,
        { desc = 'wrap' },
      },
      {
        'c',
        function()
          require('util').toggle('cursorline', { silent = true })
        end,
        { desc = 'cursor line' },
      },
      {
        'd',
        function()
          require('plugins.lspconfig.diagnostic').toggle()
        end,
        { desc = 'diagnostics' },
      },
      {
        'f',
        function()
          require('plugins.lspconfig.formatting').toggle()
        end,
        { exit = true, desc = 'format on save' },
      },
      {
        'b',
        function()
          require('gitsigns').toggle_current_line_blame()
        end,
        { desc = 'git blame line' },
      },
      { '<Esc>', nil, { exit = true } },
      { 'q', nil, { exit = true } },
    },
  }
end

local function git_widget()
  local Hydra = require('hydra')
  local cmd = require('hydra.keymap-util').cmd

  local hint = [[
  ^_J_/_K_: next/prev hunk    _s_: stage hunk     _S_: stage file
  ^^^  _p_: preview hunk      _u_: unstage hunk   _U_: unstage file  ^
  ^^^  _d_: toggle deleted    _r_: reset hunk     _R_: reset file
  ^^^  _D_: diff file
  ^^^  _b_: blame line
  ^^^  _B_: blame file
  ^
  ^ ^              _<Enter>_: Neogit         _<ESC>_/_q_: exit
]]
  Hydra {
    name = 'Git',
    hint = hint,
    config = {
      -- buffer = bufnr,
      color = 'pink',
      invoke_on_body = true,
      hint = {
        border = 'single',
      },
      on_enter = function()
        local gitsigns = require('gitsigns')
        -- mkview
        -- vim.cmd('mkview')
        -- vim.cmd('silent! %foldopen!')

        -- vim.bo.modifiable = false
        -- gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
        gitsigns.toggle_deleted(true)
      end,
      on_exit = function()
        local gitsigns = require('gitsigns')
        -- loadview
        -- vim.cmd('loadview')
        -- local cursor_pos = vim.api.nvim_win_get_cursor(0)
        -- vim.api.nvim_win_set_cursor(0, cursor_pos)
        -- vim.cmd('normal zv')

        -- vim.bo.modifiable = true
        -- gitsigns.toggle_signs(false)
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
      end,
    },
    mode = { 'n', 'x' },
    body = '<leader>G',
    heads = {
      {
        'J',
        function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            local gitsigns = require('gitsigns')
            gitsigns.next_hunk()
          end)
          return '<Ignore>'
        end,
        { expr = true, desc = 'next hunk' },
      },
      {
        'K',
        function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            local gitsigns = require('gitsigns')
            gitsigns.prev_hunk()
          end)
          return '<Ignore>'
        end,
        { expr = true, desc = 'prev hunk' },
      },
      { 's', cmd('lua require("gitsigns").stage_hunk()'), { silent = true, desc = 'stage hunk' } },
      { 'S', cmd('lua require("gitsigns").stage_buffer()'), { desc = 'stage buffer' } },
      { 'u', cmd('lua require("gitsigns").undo_stage_hunk()'), { desc = 'unstage hunk' } },
      { 'U', cmd('lua require("gitsigns").reset_buffer_index()'), { desc = 'unstage file' } },
      { 'r', cmd('lua require("gitsigns").reset_hunk()'), { desc = 'reset hunk' } },
      { 'R', cmd('lua require("gitsigns").reset_buffer()'), { desc = 'reset buffer' } },
      { 'p', cmd('lua require("gitsigns").preview_hunk()'), { desc = 'preview hunk' } },
      { 'd', cmd('lua require("gitsigns").toggle_deleted()'), { nowait = true, desc = 'toggle deleted' } },
      {
        'D',
        function()
          vim.defer_fn(function()
            require('gitsigns').diffthis()
          end, 50)
        end,
        { exit = true, desc = 'diff file' },
      },
      { 'b', cmd('lua require("gitsigns").blame_line()'), { desc = 'blame' } },
      {
        'B',
        cmd('lua require("gitsigns").blame_line { full = true }'),
        { desc = 'blame show full' },
      },
      { '<Enter>', '<Cmd>Neogit<CR>', { exit = true, desc = 'Neogit' } },
      { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
      { '<ESC>', nil, { exit = true, nowait = true, desc = 'exit' } },
    },
  }
end

local function telescope_widget()
  local Hydra = require('hydra')
  local cmd = require('hydra.keymap-util').cmd

  local hint = [[
  _f_: files             _g_: live grep
  _r_: recent files      _w_: find current word  ^
  _R_: frecency          _/_: search in buffer
  _b_: buffers
  ^
  _p_: projects          _;_: insert symbols
  _c_: clipboard         _h_: help tags
  _e_: file explorer     _n_: notifications
  ^
  ^
  _<SPACE>_: resume
     _<CR>_: Telescope          _<ESC>_/_q_: exit
]]

  Hydra {
    name = 'Telescope',
    hint = hint,
    mode = { 'n', 'x' },
    config = {
      color = 'teal',
      invoke_on_body = true,
      hint = {
        border = 'single',
      },
    },
    body = '<leader>f',
    heads = {
      -- files
      { 'f', cmd('lua require("plugins.telescope").project_files()'), { desc = 'Find files' } },
      { 'r', cmd('Telescope oldfiles'), { desc = 'Recent files' } },
      { 'R', cmd('Telescope frecency'), { desc = 'Frecency files' } },
      { 'b', cmd('Telescope buffers'), { desc = 'Buffers' } },
      -- text
      { 'g', cmd('Telescope live_grep'), { desc = 'Live grep' } },
      { 'w', cmd('Telescope grep_string'), { desc = 'Grep current word' } },
      { '/', cmd('Telescope current_buffer_fuzzy_find'), { desc = 'Search in buffer' } },

      { 'c', cmd('YankyRingHistory'), { desc = 'Clipboard' } },
      { 'p', cmd('Telescope projects'), { desc = 'Projects' } },
      { 'e', cmd('Telescope file_browser'), { desc = 'File explorer' } },
      { 'n', cmd('Telescope notify'), { desc = 'Notifications' } },
      { 'h', cmd('Telescope help_tags'), { desc = 'Helps' } },
      { ';', cmd('Telescope symbols'), { desc = 'Insert symbols' } },

      { '<CR>', cmd('Telescope'), { desc = 'Telescope' } },
      { '<SPACE>', cmd('Telescope resume'), { desc = 'Resume' } },
      { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
      { '<ESC>', nil, { exit = true, nowait = true, desc = 'exit' } },
    },
  }
end

spec.config = function()
  scroll_widget()
  -- window_widget()
  option_menu()
  git_widget()
  -- telescope_widget()
end

return { spec }

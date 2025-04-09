-- editor widgets
--
-- [which-key.nvim]:             keymap cheatsheet
-- [neo-tree.nvim]:              file explorer
-- [fzf.lua]:                    fuzzy finder
-- [aerial]                      symbol list
-- [gitsigns]                    git integration
-- [harpoon]                     quick file switcher

return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts_extend = { 'spec', 'icons.rules' },
    opts = {
      preset = 'helix',
      spec = {
        { '<leader><tab>', group = 'Tabs' },
        { '<leader>b', group = 'Buffers' },
        { '<leader>f', group = 'Find' },
        { '<leader>g', group = 'Git', icon = { icon = '󰘬', color = 'orange' } },
        { '<leader>gh', group = 'Hunk' },
        { '<leader>l', group = 'Language', icon = '󰅩' },
        { '<leader>s', group = 'Search' },
        { '<leader>\\', group = 'Toggles' },
      },
      icons = {
        breadcrumb = '>',
        separator = '󰁔',
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show {
            global = false,
          }
        end,
        desc = 'Local keymaps (which-key)',
      },
      {
        '<c-w><space>',
        function()
          require('which-key').show {
            keys = '<c-w>',
            loop = true,
          }
        end,
        desc = 'Window Hydra Mode (which-key)',
      },
    },
  },

  -- file explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    lazy = false, -- neo-tree will lazily load itself
    cmd = 'Neotree',
    keys = {
      {
        '<leader>e',
        function()
          -- require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
          require('neo-tree.command').execute {
            reveal = true,
            position = 'float',
            toggle = true,
            dir = vim.uv.cwd(),
          }
        end,
        desc = 'Explorer NeoTree (Root Dir)',
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    opts = {
      sources = { 'filesystem' },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_by_pattern = {
            '*.o',
            '*.lo',
          },
        },
        commands = {
          toggle_current = function(state)
            local tree = state.tree
            local node = tree:get_node()
            if node.type ~= 'directory' then
              node = tree:get_node(node:get_parent_id())
              require('neo-tree.ui.renderer').focus_node(state, node:get_id())
            end
            require('neo-tree.sources.filesystem').toggle_directory(state, node)
          end,
          backward = function(state)
            local node = state.tree:get_node()
            if node.type == 'message' then
              return
            end
            if node.type ~= 'directory' or not node:is_expanded() then
              node = state.tree:get_node(node:get_parent_id())
              require('neo-tree.ui.renderer').focus_node(state, node:get_id())
            end
            require('neo-tree.sources.filesystem').toggle_directory(state, node)
          end,
          forward = function(state)
            local node = state.tree:get_node()
            if node.type == 'message' then
              return
            end
            if node.type ~= 'directory' or not node:is_expanded() then
              require('neo-tree.sources.filesystem.commands').open(state)
            end
          end,
        },
        window = {
          mappings = {
            -- navigation with hjkl
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#navigation-with-hjkl
            ['h'] = 'backward',
            ['l'] = 'forward',
            ['<tab>'] = 'toggle_current',
            ['z'] = 'none',
            ['zc'] = 'close_node',
            ['zC'] = 'close_all_subnodes',
            ['zM'] = 'close_all_nodes',
            ['zR'] = 'expand_all_nodes',
            ['w'] = 'none',
          },
        },
      },
    },
  },

  -- [fzf.lua] fuzzy finder
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    opts = {
      nbsp = '\xc2\xa0',
    },
    keys = {
      -- resume
      { '<leader><space>', '<cmd>FzfLua resume<cr>', desc = 'Resume picker' },
      -- find files
      {
        '<leader>ff',
        function()
          require('fzf-lua').files()
        end,
        desc = 'Find Files (Root Dir)',
      },
      {
        '<C-p>',
        function()
          require('fzf-lua').files()
        end,
        desc = 'Find Files (Root Dir)',
      },
      { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Recent Files' },
      { '<leader>fg', '<cmd>FzfLua git_files<cr>', desc = 'Git Files' },
      { '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Buffers' },

      -- greps
      -- { '<leader>sg', '<cmd>FzfLua live_grep', desc = 'Grep (Root Dir)'},
      { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = 'Grep (CWD)' },
      { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'Current Word (CWD)' },
      { '<leader>sw', '<cmd>FzfLua grep_visual<cr>', mode = 'v', desc = 'Selection (CWD)' },

      -- misc
      { '<leader>f"', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
      { '<leader>fH', '<cmd>FzfLua highlights<cr>', desc = 'Highlights' },
      { '<leader>fK', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps' },
      { '<leader>fM', '<cmd>FzfLua manpages<cr>', desc = 'Manpages' },
      { '<leader>fC', '<cmd>FzfLua colorschemes<cr>', desc = 'Colorschemes' },
    },
  },

  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>ls', '<cmd>AerialToggle<cr>', desc = 'Symbols (Aerial)' },
      { '<leader>;', '<cmd>AerialToggle<cr>', desc = 'Symbols (Aerial)' },
    },
    opts = {},
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      on_attach = function(buffer)
        local gitsigns = require('gitsigns')

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = buffer })
        end

        map('n', '[g', function()
          if vim.wo.diff then
            vim.cmd.normal { '[g', bang = true }
          else
            gitsigns.nav_hunk('prev')
          end
        end, 'Previous Hunk')
        map('n', ']g', function()
          if vim.wo.diff then
            vim.cmd.normal { ']g', bang = true }
          else
            gitsigns.nav_hunk('next')
          end
        end, 'Next Hunk')
        map({ 'n', 'v' }, '<leader>ghs', gitsigns.stage_hunk, '(Un)Stage Hunk')
        map({ 'n', 'v' }, '<leader>ghr', gitsigns.reset_hunk, 'Reset Hunk')
        map('n', '<leader>ghp', gitsigns.preview_hunk_inline, 'Stage Buffer')
        map('n', '<leader>ghS', gitsigns.stage_buffer, 'Stage Buffer')
        map('n', '<leader>ghR', gitsigns.reset_buffer, 'Reset Buffer')
        map('n', '<leader>gb', function()
          gitsigns.blame_line { full = true }
        end, 'Blame Line')
        map('n', '<leader>gB', gitsigns.blame, 'Blame Buffer')
        map('n', '<leader>gd', gitsigns.diffthis, 'Diffthis')
        map('n', '<leader>gD', function()
          gitsigns.diffthis('~')
        end, 'Diffthis~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Git Hunk')
        map({ 'o', 'x' }, 'ah', ':<C-U>Gitsigns select_hunk<CR>', 'Git Hunk')
      end,
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      Snacks.toggle({
        id = 'git_signs',
        name = 'Git Signs',
        get = function()
          return require('gitsigns.config').config.signcolumn
        end,
        set = function(state)
          require('gitsigns').toggle_signs(state)
        end,
      }):map('<leader>\\g')
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'folke/which-key.nvim',
        opts = {
          icons = {
            rules = {
              { plugin = 'harpoon', icon = '󰒤', color = 'azure' },
            },
          },
        },
      },
    },
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          '<leader>H',
          function()
            local harpoon = require('harpoon')
            harpoon:list():add()
          end,
          desc = 'Harpoon Add File',
        },
        {
          '<leader>h',
          function()
            local harpoon = require('harpoon')
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = 'Harpoon Quick Menu',
        },
      }
      for i = 1, 5 do
        table.insert(keys, {
          '<leader>' .. i,
          function()
            local harpoon = require('harpoon')
            harpoon:list():select(i)
          end,
          desc = 'Harpoon to File ' .. i,
        })
      end
      return keys
    end,
    config = function(_, opts)
      local harpoon = require('harpoon')
      harpoon:setup(opts)

      -- Highlight current file in the harpoon buffer list
      local harpoon_extensions = require('harpoon.extensions')
      harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

      -- add keymaps for opening files in splits & tabs.
      harpoon:extend {
        UI_CREATE = function(cx)
          vim.keymap.set('n', '<C-v>', function()
            harpoon.ui:select_menu_item { vsplit = true }
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-x>', function()
            harpoon.ui:select_menu_item { split = true }
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-t>', function()
            harpoon.ui:select_menu_item { tabedit = true }
          end, { buffer = cx.bufnr })
        end,
      }
    end,
  },
}

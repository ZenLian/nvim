---@type LazyPluginSpec[]
return {
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
            toggle = true,
            dir = vim.uv.cwd(),
          }
        end,
        desc = 'Explorer NeoTree (CWD)',
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    --- @type neotree.Config
    opts = {
      sources = { 'filesystem' },
      filesystem = {
        hijack_netrw_behavior = 'disabled',
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

  {
    'stevearc/oil.nvim',
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    --lazy = false,
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    keys = {
      {
        '<leader>E',
        '<cmd>Oil<cr>',
        desc = 'Explorer Oil',
      },
    },
    opts = function()
      local detail = false
      ---@module 'oil'
      ---@type oil.SetupOpts
      return {
        default_file_explorer = false,
        keymaps = {
          ['q'] = { 'actions.close', mode = 'n' },
          ['gd'] = {
            desc = 'Toggle file detail view',
            callback = function()
              detail = not detail
              if detail then
                require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
              else
                require('oil').set_columns { 'icon' }
              end
            end,
          },
          ['<C-h>'] = false,
          ['<C-l>'] = false,
          ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
          ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
          ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        },
      }
    end,
  },

  ---@type LazySpec
  {
    'mikavilpas/yazi.nvim',
    -- event = 'VeryLazy',
    lazy = false,
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      'folke/snacks.nvim',
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>-',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Explorer yazi(cfile)',
      },
      {
        -- Open in the current working directory
        '<leader>fe',
        '<cmd>Yazi cwd<cr>',
        desc = 'Explorer yazi(CWD)',
      },
      {
        '<leader>/',
        '<cmd>Yazi toggle<cr>',
        desc = 'Explorer yazi(resume)',
      },
    },
    ---@module 'yazi'
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
}

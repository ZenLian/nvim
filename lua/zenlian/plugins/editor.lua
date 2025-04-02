-- editor widgets
--
-- [which-key.nvim]:             keymap cheatsheet
-- [neo-tree.nvim]:              file explorer
-- [fzf.lua]:                    fuzzy finder

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { '<leader>b', desc = 'Buffers' },
        { '<leader>f', desc = 'Find' },
        { '<leader>s', desc = 'Search' },
      }
    },
    keys = {
      {
        '<leader>?',
        function()
          require("which-key").show({
            global = false
          })
        end,
        desc = "Show local keymaps"
      },
    }
  },

  -- file explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    cmd = 'Neotree',
    keys = {
      {
        "<leader>e",
        function()
          -- require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (Root Dir)"
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    opts = {
      sources = { "filesystem" },
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
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = {},
    keys = {
      -- resume
      { '<leader><space>', '<cmd>FzfLua resume<cr>', desc = 'Resume picker'},
      -- find files
      {
        '<leader>ff',
        function ()
          require('fzf-lua').files()
        end,
        desc = "Find Files (Root Dir)"
      },
      {
        '<C-p>',
        function ()
          require('fzf-lua').files()
        end,
        desc = "Find Files (Root Dir)"
      },
      { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Recent Files'},
      { '<leader>fg', '<cmd>FzfLua git_files<cr>', desc = 'Git Files'},
      { '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Buffers'},

      -- greps
      -- { '<leader>sg', '<cmd>FzfLua live_grep', desc = 'Grep (Root Dir)'},
      { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = 'Grep (CWD)'},
      { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'Current Word (CWD)'},
      { '<leader>sw', '<cmd>FzfLua grep_visual<cr>', mode = 'v', desc = 'Selection (CWD)'},

      -- misc
      { '<leader>f"', '<cmd>FzfLua registers<cr>', desc = 'Registers'},
      { '<leader>fH', '<cmd>FzfLua highlights<cr>', desc = 'Highlights'},
      { '<leader>fK', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps'},
      { '<leader>fM', '<cmd>FzfLua manpages<cr>', desc = 'Manpages'},
      { '<leader>fC', '<cmd>FzfLua colorschemes<cr>', desc = 'Colorschemes'},
    }
  }
}
vim.pack.add({
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- dependencies:
  -- plenary.nvim
  -- nui.nvim
  -- mini.icons
})

require('neo-tree').setup {
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
}

vim.keymap.set('n',
  '<leader>e',
  function()
    -- require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
    require('neo-tree.command').execute {
      reveal = true,
      toggle = true,
      dir = vim.uv.cwd(),
    }
  end,
  { desc = 'Explorer NeoTree (CWD)', }
)

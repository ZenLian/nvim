return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      filesystem = {
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
            ['z'] = '',
            ['zz'] = 'close_all_nodes',
            ['zr'] = 'expand_all_nodes',
            ['w'] = '',
          },
        },
      },
    },
  },
}

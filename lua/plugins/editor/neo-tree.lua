local spec = {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  cmd = { 'Neotree' },
  keys = {
    { '<C-e>', '<cmd>Neotree float toggle reveal<CR>', desc = 'toggle Neotree' },
    -- { '<Leader>e', '<cmd>Neotree float toggle reveal<CR>', desc = 'Toggle neotree' },
  },
}

spec.config = function()
  local function getTelescopeOpts(state, path)
    return {
      cwd = path,
      search_dirs = { path },
      attach_mappings = function(prompt_bufnr)
        local actions = require('telescope.actions')
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local action_state = require('telescope.actions.state')
          local selection = action_state.get_selected_entry()
          local filename = selection.filename
          if filename == nil then
            filename = selection[1]
          end
          -- any way to open the file without triggering auto-close event of neo-tree?
          require('neo-tree.sources.filesystem').navigate(state, state.path, filename)
        end)
        return true
      end,
    }
  end
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  require('neo-tree').setup {
    default_component_configs = {
      icon = {
        folder_closed = '',
        folder_open = '',
        -- folder_empty = 'ﰊ',
        -- folder_empty = '',
        -- default = '',
      },
      modified = {
        symbol = ' ',
      },
      git_status = {
        symbols = {
          -- Change type
          added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = 'D', -- this can only be used in the git_status source
          renamed = '', -- this can only be used in the git_status source
          -- Status type
          untracked = '?',
          ignored = 'I',
          unstaged = 'U',
          staged = 'S',
          conflict = 'C',
        },
      },
    },
    source_selector = {
      winbar = true,
    },
    window = {
      width = 30,
      mappings = {
        ['<space>'] = '',
        ['s'] = '',
        ['S'] = '',
        ['t'] = '',
        ['<C-v>'] = 'open_vsplit',
        ['<C-s>'] = 'open_split',
        ['<C-t>'] = 'open_tabnew',
      },
    },
    filesystem = {
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
        trash = function(state)
          local tree = state.tree
          local node = tree:get_node()
          if node.type == 'message' then
            return
          end
          local _, name = require('neo-tree.utils').split_path(node.path)
          local msg = string.format("Are you sure you want to trash '%s'?", name)
          require('neo-tree.ui.inputs').confirm(msg, function(confirmed)
            if not confirmed then
              return
            end
            vim.api.nvim_command('silent !trash ' .. node.path)
            require('neo-tree.sources.filesystem.commands').refresh(state)
          end)
        end,
        trash_visual = function(state, selected_nodes)
          local paths_to_trash = {}
          for _, node in ipairs(selected_nodes) do
            if node.type ~= 'message' then
              table.insert(paths_to_trash, node.path)
            end
          end
          local msg = 'Are you sure you want to trash ' .. #paths_to_trash .. ' items?'
          require('neo-tree.ui.inputs').confirm(msg, function(confirmed)
            if not confirmed then
              return
            end
            for _, path in ipairs(paths_to_trash) do
              vim.api.nvim_command('silent !trash ' .. path)
            end
            require('neo-tree.sources.filesystem.commands').refresh(state)
          end)
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
        telescope_find = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require('telescope.builtin').find_files(getTelescopeOpts(state, path))
        end,
        telescope_grep = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require('telescope.builtin').live_grep(getTelescopeOpts(state, path))
        end,
      },
      filtered_items = {
        hide_dotfiles = false,
      },
      follow_current_file = true,
      window = {
        mappings = {
          -- navigation with hjkl
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#navigation-with-hjkl
          ['h'] = 'backward',
          ['l'] = 'forward',
          ['C'] = '',
          ['<tab>'] = 'toggle_current',
          ['D'] = 'trash',
          ['z'] = '',
          ['zz'] = 'close_all_nodes',
          ['zr'] = 'expand_all_nodes',
          ['sf'] = 'telescope_find',
          ['sg'] = 'telescope_grep',
        },
      },
    },
  }
end

return { spec }

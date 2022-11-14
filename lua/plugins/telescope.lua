local M = {}

M.config = function()
  local packer = require('util.packer')
  local telescope = require('telescope')

  local file_browser_actions = function(action)
    return function(...)
      local actions = require('telescope').extensions.file_browser.actions
      return actions[action](...)
    end
  end

  local dropdown = {
    theme = 'dropdown',
    previewer = false,
    height = 25,
  }

  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ['<C-/>'] = 'which_key',
          ['<C-k>'] = 'move_selection_previous',
          ['<C-j>'] = 'move_selection_next',
        },
      },
      prompt_prefix = ' ',
      selection_caret = ' ',
      sorting_strategy = 'ascending',
      layout_strategy = 'bottom_pane',
      layout_config = {
        prompt_position = 'top',
        height = 25,
      },
      -- border = false,
      -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      history = {
        path = vim.fn.stdpath('data') .. '/databases/telescope_history.sqlite3',
        limit = 100,
      },
    },
    pickers = {
      builtin = dropdown,
      find_files = dropdown,
      git_files = dropdown,
      oldfiles = dropdown,
    },
    extensions = {
      frecency = {
        db_root = vim.fn.stdpath('data') .. '/databases',
        show_scores = true,
        show_unindexed = true,
        ignore_patterns = { '*.git/*', '*/tmp/*' },
      },
      file_browser = {
        -- theme = 'ivy',
        initial_mode = 'normal',
        mappings = {
          n = {
            ['a'] = file_browser_actions('create'),
            ['l'] = file_browser_actions('select_default'),
            ['h'] = file_browser_actions('goto_parent_dir'),
          },
        },
      },
      themes = dropdown,
    },
  }

  -- require('telescope').load_extension('themes')
  -- telescope.load_extension('fzf')
  -- telescope.load_extension('file_browser')

  telescope.load_extension('notify')
  -- telescope.load_extension('persisted') -- To load the telescope extension
end

M.project_files = function()
  local builtin = require('telescope.builtin')
  local opts = { show_untracked = true }
  local in_git_repo = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
  if in_git_repo then
    builtin.git_files(opts)
  else
    local clients = vim.lsp.get_active_clients()
    if #clients > 0 then
      opts.cwd = clients[1].config.root_dir
    end
    builtin.find_files(opts)
  end
end

return M

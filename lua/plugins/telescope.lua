local M = {}

M.config = function()
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
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        -- '--glob="!.git/*"',
      },
      mappings = {
        i = {
          ['<C-/>'] = 'which_key',
          ['<C-k>'] = 'move_selection_previous',
          ['<C-j>'] = 'move_selection_next',
        },
      },
      history = {
        path = vim.fn.stdpath('data') .. '/databases/telescope_history.sqlite3',
        limit = 100,
      },
      prompt_prefix = ' ',
      selection_caret = ' ',
      -- border = false,
      -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      sorting_strategy = 'ascending',
      layout_strategy = 'bottom_pane',
      layout_config = {
        prompt_position = 'top',
        height = 25,
      },
    },
    pickers = {
      builtin = dropdown,
      filetypes = dropdown,
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
    },
  }

  telescope.load_extension('notify')
  telescope.load_extension('projects')
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
    opts.hidden = true
    builtin.find_files(opts)
  end
end

return M

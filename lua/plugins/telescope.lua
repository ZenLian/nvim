local config = function()
  -- file_browser actions
  -- TODO: 这时插件还没加载， extensions 会报错，所以把函数放在闭包里延后执行
  local fb_actions = function(action)
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

  require('telescope').setup {
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
      -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
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
            ['a'] = fb_actions('create'),
            ['l'] = 'select_default',
            ['h'] = fb_actions('goto_parent_dir'),
          },
        },
      },
      themes = dropdown,
    },
  }

  -- require('telescope').load_extension('themes')
  require('telescope').load_extension('notify')
end

local project_files = function()
  local in_git_repo = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
  if in_git_repo then
    require('telescope.builtin').git_files()
  else
    require('telescope.builtin').find_files()
  end
end

return {
  config = config,
  project_files = project_files,
}

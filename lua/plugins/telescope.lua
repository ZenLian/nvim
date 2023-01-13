local spec = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-frecency.nvim', dependencies = { 'sqlite.lua' } },
    { 'nvim-telescope/telescope-symbols.nvim' },
  },
  opts = function()
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
      mappings = {
        i = {
          ['<esc>'] = require('telescope.actions').close,
        },
      },
    }

    return {
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
        symbols = dropdown,
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
              ['l'] = require('telescope.actions').select_default,
              ['h'] = file_browser_actions('goto_parent_dir'),
              ['H'] = file_browser_actions('toggle_hidden'),
              ['/'] = file_browser_actions('toggle_all'),
            },
          },
        },
      },
    }
  end,
}

spec.config = function(_, opts)
  local telescope = require('telescope')

  telescope.setup(opts)
  telescope.load_extension('fzf')
  telescope.load_extension('notify')
  telescope.load_extension('frecency')
  --telescope.load_extension('projects')
end

local function project_files()
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

local function cmd(scope)
  return ('<cmd>Telescope %s<cr>'):format(scope or '')
end

spec.keys = {
  { '<C-p>', project_files, desc = 'Project files' },
  { '<C-f>', cmd('current_buffer_fuzzy_find'), desc = 'Find in current buffer' },

  { '<Leader>f<space>', cmd(''), desc = 'Telescope' },
  { '<Leader><SPACE>', cmd('resume'), desc = 'Resume' },

  -- { '<Leader>ff', cmd('find_files'), desc = 'Find files' },
  { '<Leader>ff', cmd('frecency'), desc = 'Frecency files' },
  { '<Leader>fr', cmd('oldfiles'), desc = 'Recent files' },
  { '<Leader>fb', cmd('buffers'), desc = 'Buffers' },

  { '<Leader>fg', cmd('live_grep'), desc = 'Live grep' },
  { '<Leader>fw', cmd('grep_string'), desc = 'Grep current word' },
  { '<Leader>f/', cmd('current_buffer_fuzzy_find'), desc = 'Find in current buffer' },

  { '<Leader>fp', cmd('projects'), desc = 'Projects' },
  { '<Leader>fe', cmd('file_browser'), desc = 'File explorer' },
  { '<Leader>fn', cmd('notify'), desc = 'Notifications' },
  { '<Leader>fh', cmd('help_tags'), desc = 'Helps' },
  { '<Leader>f;', cmd('symbols'), desc = 'Symbols' },

  {
    '<leader>gB',
    function()
      require('telescope').git_branches()
    end,
    desc = 'Branches',
  },
  {
    '<leader>gC',
    function()
      require('telescope').git_commits()
    end,
    desc = 'Commits',
  },
  {
    '<leader>gS',
    function()
      require('telescope').git_status()
    end,
    desc = 'Status',
  },
}

return { spec }

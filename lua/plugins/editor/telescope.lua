local config = require("config")

local spec = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-frecency.nvim',   dependencies = { 'sqlite.lua' } },
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
            ['<esc>'] = require('telescope.actions').close,
          },
        },
        history = {
          path = vim.fn.stdpath('data') .. '/databases/telescope_history.sqlite3',
          limit = 100,
        },
        prompt_prefix = config.icons.enabled and ' ' or '> ',
        selection_caret = config.icons.enabled and ' ' or '> ',
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
  telescope.load_extension('projects')
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

local function ts(scope)
  return ('<cmd>Telescope %s<cr>'):format(scope or '')
end

spec.keys = {
  { '<C-p>',            project_files,                                               desc = 'Project files' },
  { '<C-f>',            ts('current_buffer_fuzzy_find'),                             desc = 'Find in current buffer' },
  { '<Leader>f<space>', ts('builtin include_extensions=true'),                       desc = 'Telescope' },
  { "<Leader>'",        ts('resume'),                                                desc = 'Telescope Resume' },

  -- { '<Leader>ff', cmd('find_files'), desc = 'Find files' },
  { '<Leader>ff',       ts('frecency workspace=CWD theme=dropdown previewer=false'), desc = 'Frecency files' },
  { '<Leader>fr',       ts('oldfiles'),                                              desc = 'Recent files' },
  { '<Leader>fb',       ts('buffers'),                                               desc = 'Buffers' },
  { '<Leader>fg',       ts('live_grep'),                                             desc = 'Live grep' },
  { '<Leader>fw',       ts('grep_string'),                                           desc = 'Grep current word' },
  { '<Leader>f/',       ts('current_buffer_fuzzy_find'),                             desc = 'Find in current buffer' },
  { '<Leader>fp',       ts('projects'),                                              desc = 'Projects' },
  { '<Leader>fe',       ts('file_browser'),                                          desc = 'File explorer' },
  { '<Leader>fn',       ts('notify'),                                                desc = 'Notifications' },
  { '<Leader>fh',       ts('help_tags'),                                             desc = 'Helps' },
  { '<Leader>f;',       ts('symbols'),                                               desc = 'Symbols' },

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

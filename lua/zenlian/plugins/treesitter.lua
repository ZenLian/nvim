---@type LazyPluginSpec[]
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    version = 'false',
    lazy = false,
    build = ':TSUpdate',
    event = { 'VeryLazy' },
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
    keys = {
      { 'g+', desc = 'Init Selection',      mode = 'n' },
      { '+',  desc = 'Increment Selection', mode = 'x' },
      { '-',  desc = 'Decrement Selection', mode = 'x' },
    },
    opts_extend = { 'ensure_installed' },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'printf',
        'python',
        'query',
        'regex',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'g+',
          node_incremental = '+',
          scope_incremental = false,
          node_decremental = '-',
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter').setup(opts)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'VeryLazy',
    enabled = true,
    opts = {
      move = {
        enable = true,
        set_jumps = true,
        keys = {
          -- '[c', ']c' is for vimdiff, so we use `[l`, ']l'
          goto_next_start = { [']f'] = '@function.outer', [']l'] = '@class.outer', [']a'] = '@parameter.inner' },
          goto_next_end = { [']F'] = '@function.outer', [']L'] = '@class.outer', [']A'] = '@parameter.inner' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[l'] = '@class.outer', ['[a'] = '@parameter.inner' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[L'] = '@class.outer', ['[A'] = '@parameter.inner' },
        }
      },
    },
    config = function(_, opts)
      require('nvim-treesitter-textobjects').setup(opts)
    end,
  },

  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Automatically add closing tags for HTML and JSX
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {},
  },

  -- rainbow brackets
  {
    'HiPhish/rainbow-delimiters.nvim',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    -- event = "User ZLFile",
    init = function()
      vim.g.rainbow_delimiters = {
        strategy = {
          -- Disabled for very large files
          [''] = function(bufnr)
            local lines = vim.api.nvim_buf_line_count(bufnr)
            if lines > 10000 then
              return nil
            else
              return 'rainbow-delimiters.strategy.global'
            end
          end,
        },
        query = {
          [''] = 'rainbow-delimiters',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          -- 'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
}

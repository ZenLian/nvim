local spec = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    { 'nvim-treesitter/nvim-treesitter-context', config = true },
    'HiPhish/nvim-ts-rainbow2',
  },
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cmake',
      'cpp',
      'css',
      'dockerfile',
      'go',
      'help',
      'html',
      'javascript',
      'json',
      'jsonc',
      'latex',
      'lua',
      'markdown',
      'python',
      'rust',
      'scss',
      'toml',
      'typescript',
      'vim',
      'yaml',
    },
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'vn',
        node_incremental = '+',
        node_decremental = '-',
        -- scope_incremental = '',
      },
    },
  },
  config = function(_, opts)
    local rainbow = require('ts-rainbow')
    opts.rainbow = {
      enable = true,
      -- list of languages you want to disable the plugin for
      disable = {},
      -- Which query to use for finding delimiters
      query = {
        'rainbow-parens',
        html = 'rainbow-tags',
        latex = 'rainbow-blocks',
      },
      strategy = rainbow.strategy['local'],
      hlgroups = {
        'TSRainbowYellow',
        'TSRainbowCyan',
        'TSRainbowOrange',
        'TSRainbowViolet',
        'TSRainbowBlue',
        'TSRainbowGreen',
        'TSRainbowRed',
      },
    }
    require('nvim-treesitter.configs').setup(opts)
  end,
}

return {
  spec,
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
    dependencies = 'nvim-treesitter',
  },
  {
    'mfussenegger/nvim-treehopper',
    keys = {
      { 'm', ':lua require("tsht").nodes()<CR>', desc = 'Select ts node', mode = 'x' },
      { 'm', ':<C-U>lua require("tsht").nodes()<CR>', desc = 'Select ts node', mode = 'o' },
    },
    dependencies = 'nvim-treesitter',
    config = function()
      require('tsht').config.hint_keys = { 'j', 'k', 'l', 'f', 'd', 's', 'w', 'e', 'i', 'm' }
    end,
  },
}

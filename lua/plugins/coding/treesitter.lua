local ts_spec = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
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
      'vimdoc',
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
    require('nvim-treesitter.configs').setup(opts)
  end,
}

return {
  ts_spec,
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

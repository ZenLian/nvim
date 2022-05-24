local completion = {}

completion['neovim/nvim-lspconfig'] = {
  -- opt = true,
  -- module = "lspconfig",
  event = 'BufReadPre',
  config = function()
    require('plugins.completion.lspconfig')
  end,
  requires = {
    'williamboman/nvim-lsp-installer',
    {
      'folke/lua-dev.nvim',
      module = 'lua-dev',
    },
    {
      'jose-elias-alvarez/null-ls.nvim',
      module = 'null-ls',
    },
    {
      'b0o/schemastore.nvim',
      module = 'schemastore',
    },
  },
}

completion['hrsh7th/nvim-cmp'] = {
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function()
    require('plugins.completion.cmp')
  end,
  requires = {
    {
      'L3MON4D3/LuaSnip',
      requires = 'rafamadriz/friendly-snippets',
      after = 'nvim-cmp',
      config = function()
        require('plugins.completion.luasnip')
      end,
    },
    { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
    { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
    { 'uga-rosa/cmp-dictionary', after = 'nvim-cmp' },
  },
}

completion['windwp/nvim-autopairs'] = {
  after = 'nvim-cmp',
  -- module = "nvim-autopairs",
  config = function()
    require('plugins.completion.autopairs')
  end,
}

completion['stevearc/aerial.nvim'] = {
  module = 'aerial',
  cmd = 'AerialToggle',
  config = function()
    require('plugins.completion.aerial')
  end,
}

completion['folke/trouble.nvim'] = {
  requires = 'kyazdani42/nvim-web-devicons',
  cmd = 'Trouble',
  module = 'trouble',
  config = function()
    require('plugins.completion.trouble')
  end,
}

return completion

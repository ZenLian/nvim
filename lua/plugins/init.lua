-- vim:foldmethod=marker:foldmarker={{{,}}}:
local plugins = {
  --{{{ requirements
  {
    'nvim-lua/plenary.nvim',
    module = 'plenary',
  },
  {
    'MunifTanjim/nui.nvim',
    module = 'nui',
  },
  {
    'kkharji/sqlite.lua',
    module = 'sqlite',
  },
  {
    'kyazdani42/nvim-web-devicons',
    module = 'nvim-web-devicons',
    config = true,
  },
  ---}}} requirements

  -- {{{ ui
  {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = true,
  },
  {
    'rebelot/heirline.nvim',
    event = 'VimEnter',
    config = true,
  },
  {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = 'kyazdani42/nvim-web-devicons',
    after = 'catppuccin',
    config = true,
  },
  {
    'goolord/alpha-nvim',
    event = 'BufWinEnter',
    config = true,
  },
  {
    'rcarriga/nvim-notify',
    event = 'VimEnter',
    config = true,
  },
  {
    'stevearc/dressing.nvim',
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    config = true,
  },
  -- {
  --   'NvChad/nvim-colorizer.lua',
  --   config = true,
  -- },
  -- #123344
  {
    'uga-rosa/ccc.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = true,
  },
  {
    'RRethy/vim-illuminate',
    config = true,
  },
  {
    'Pocco81/true-zen.nvim',
    cmd = { 'TZNarrow', 'TZFocus', 'TZMinimalist', 'TZAtaraxis' },
    config = true,
  },
  {
    'folke/twilight.nvim',
    cmd = { 'Twilight' },
  },
  {
    'kevinhwang91/nvim-ufo',
    requires = { 'kevinhwang91/promise-async', module = 'promise' },
    event = 'BufWinEnter',
    config = true,
  },
  -- }}} ui

  -- {{{ telescope
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    module = 'telescope',
    requires = 'nvim-lua/plenary.nvim',
    config = true,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    after = 'telescope.nvim',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    requires = { 'kkharji/sqlite.lua' },
    after = 'telescope.nvim',
  },
  {
    'nvim-telescope/telescope-symbols.nvim',
    after = 'telescope.nvim',
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    after = 'telescope.nvim',
    config = function()
      require('telescope').load_extension('file_browser')
    end,
  },
  -- }}} telescope

  {
    'gbprod/yanky.nvim',
    requires = { 'kkharji/sqlite.lua' },
    config = true,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    cmd = { 'Neotree' },
    config = true,
  },
  {
    'theblob42/drex.nvim',
    cmd = { 'Drex', 'DrexDrawerOpen', 'DrexDrawerToggle' },
    config = true,
  },
  {
    'ahmedkhalf/project.nvim',
    config = true,
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
    module = 'diffview',
  },
  {
    'akinsho/toggleterm.nvim',
    module = 'toggleterm',
    cmd = 'ToggleTerm',
    keys = { [[<C-\>]] },
    config = true,
  },
  {
    'folke/todo-comments.nvim',
    opt = true,
    event = { 'BufWinEnter' },
    config = true,
  },
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    config = true,
  },
  {
    'folke/which-key.nvim',
    config = true,
  },
  {
    'anuvyklack/hydra.nvim',
    config = true,
    after = 'which-key.nvim',
  },
  -- {
  --   'jiaoshijie/undotree',
  --   module = 'undotree',
  --   config = function()
  --     require('undotree').setup()
  --   end,
  -- },
  -- use vim-startuptime shell cmd(written in go)
  -- {
  --   'dstein64/vim-startuptime',
  --   cmd = 'StartupTime',
  -- },
  { 'lewis6991/impatient.nvim' },

  {
    'ellisonleao/glow.nvim',
    ft = { 'markdown' },
    cmd = 'Glow',
  },
  {
    'toppair/peek.nvim',
    ft = { 'markdown' },
    -- cmd = { 'PeekOpen', 'PeekClose', 'PeekToggle' },
    run = { 'deno task --quiet build:fast' },
    config = true,
  },

  --- treesitter {{{
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = { 'BufRead', 'BufNewFile' },
    config = true,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    opt = true,
    after = 'nvim-treesitter',
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  },
  {
    'lewis6991/nvim-treesitter-context',
    opt = true,
    after = 'nvim-treesitter',
  },
  {
    'mfussenegger/nvim-treehopper',
    module = 'tsht',
    config = function()
      require('tsht').config.hint_keys = { 'j', 'k', 'l', 'f', 'd', 's', 'w', 'e', 'i', 'm' }
    end,
  },
  {
    'ziontee113/syntax-tree-surfer',
    after = { 'nvim-treesitter' },
    config = true,
  },
  -- }}} treesitter

  {
    'p00f/nvim-ts-rainbow',
    opt = true,
    after = 'nvim-treesitter',
  },

  -- editing {{{
  {
    'numToStr/Comment.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('Comment').setup()
    end,
  },
  -- {
  --   'ur4ltz/surround.nvim',
  --   event = { 'BufRead', 'BufNewFile' },
  --   config = function()
  --     require('surround').setup { mappings_style = 'surround' }
  --   end,
  -- },
  {
    'kylechui/nvim-surround',
    event = { 'BufRead', 'BufNewFile' },
    config = true,
  },
  {
    'ggandor/leap.nvim',
    config = true,
  },
  {
    'ggandor/flit.nvim',
    after = { 'leap.nvim' },
    config = true,
  },
  -- TODO: conflicts with yanky
  -- {
  --   'ggandor/leap-spooky.nvim',
  --   after = { 'leap.nvim' },
  --   config = function()
  --     require('leap-spooky').setup()
  --   end,
  -- },
  {
    'abecodes/tabout.nvim',
    after = { 'nvim-cmp', 'nvim-treesitter' },
    config = function()
      require('tabout').setup {}
    end,
  },
  {
    'monaqa/dial.nvim',
    keys = { '<C-a>', '<C-x>' },
    config = true,
  },
  -- }}}

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = true,
  },
  {
    'gpanders/editorconfig.nvim',
    event = { 'BufRead', 'BufNewFile' },
  },

  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    module = 'cmp',
    requires = {
      { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
      { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
      { 'uga-rosa/cmp-dictionary', module = 'cmp_dictionary' },
    },
    config = true,
  },
  {
    'L3MON4D3/LuaSnip',
    after = 'nvim-cmp',
    requires = { 'rafamadriz/friendly-snippets', after = 'nvim-cmp' },
    config = true,
  },
  {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = true,
    -- module = "nvim-autopairs",
  },

  -- lsp {{{
  {
    'neovim/nvim-lspconfig',
    config = true,
    event = 'BufReadPre',
  },
  {
    'williamboman/mason.nvim',
    module = 'mason',
  },
  {
    'williamboman/mason-lspconfig.nvim',
    module = 'mason-lspconfig',
  },
  {
    'ray-x/lsp_signature.nvim',
    module = 'lsp_signature',
  },
  {
    'folke/neodev.nvim',
    module = 'neodev',
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    module = 'null-ls',
  },
  {
    'jayp0521/mason-null-ls.nvim',
    module = 'mason-null-ls',
  },

  {
    'stevearc/aerial.nvim',
    module = 'aerial',
    cmd = 'AerialToggle',
    config = true,
  },
  {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    cmd = 'Trouble',
    module = 'trouble',
    config = function()
      require('trouble').setup {
        autoclose = true,
      }
    end,
  },
  {
    -- 'b0o/schemastore.nvim',
    'SchemaStore.nvim',
    module = 'schemastore',
    is_local = true,
  },
  -- }}} lsp

  {
    'echasnovski/mini.nvim',
    config = true,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = true,
  },
}

return {
  setup = function()
    require('util.packer').setup { plugins = plugins }
  end,
}

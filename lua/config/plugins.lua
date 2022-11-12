-- vim:foldmethod=marker:foldmarker={,}:
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
  ---}}} requirements

  -- {{{ ui
  {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = true,
  },
  {
    'windwp/windline.nvim',
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
  {
    'NvChad/nvim-colorizer.lua',
    config = true,
  },
  {
    -- TODO: not neovim only
    'RRethy/vim-illuminate',
    config = true,
  },
  {
    'folke/zen-mode.nvim',
    cmd = { 'ZenMode' },
    config = true,
  },
  {
    'folke/twilight.nvim',
    cmd = { 'Twilight' },
  },
  -- {
  --   -- TODO: set manually
  --   'anuvyklack/pretty-fold.nvim',
  --   event = 'BufRead',
  --   config = function()
  --     require('pretty-fold').setup {}
  --   end,
  -- },
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
    config = function() require('telescope').load_extension('fzf') end,
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
    config = function() require('telescope').load_extension('file_browser') end,
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
    'olimorris/persisted.nvim',
    module = { 'persisted' },
    after = { 'telescope.nvim' },
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
    'p00f/nvim-ts-rainbow',
    opt = true,
    after = 'nvim-treesitter',
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function() require('Comment').setup() end,
  },
  {
    'mfussenegger/nvim-treehopper',
    opt = true,
    after = 'nvim-treesitter',
    config = true,
  },
  -- 代码块高亮很碍眼，当前单词高亮还行，以后需要再配置
  -- {
  --   'nvim-treesitter/nvim-treesitter-refactor',
  --   opt = true,
  --   after = 'nvim-treesitter',
  -- },
  {
    'ur4ltz/surround.nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function() require('surround').setup { mappings_style = 'surround' } end,
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
  -- FIXME: conflicts with yanky
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
    config = function() require('tabout').setup {} end,
  },
  {
    'monaqa/dial.nvim',
    -- module = 'dial.map',
    keys = { '<C-a>', '<C-x>' },
    config = true,
  },

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
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
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
    -- module = 'luasnip',
    after = 'nvim-cmp',
    requires = 'rafamadriz/friendly-snippets',
    config = true,
  },
  {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = true,
    -- module = "nvim-autopairs",
  },

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

  {
    'echasnovski/mini.nvim',
    config = true,
  },
}

require('util.packer').setup { plugins = plugins }

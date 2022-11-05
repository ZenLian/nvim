local cfg = require('config').config

local config = {
  display = {
    open_fn = function()
      return require('packer.util').float {
        border = 'none',
      }
    end,
  },
}

if cfg.packer.use_ssh then
  config.git = {
    default_url_format = 'git@github.com:%s',
  }
end

local plugins = {
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
    'anuvyklack/pretty-fold.nvim',
    event = 'BufRead',
  },

  {
    'nvim-lua/plenary.nvim',
    module = 'plenary',
  },
  {
    'tami5/sqlite.lua',
    module = 'sqlite',
  },
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
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    opt = true,
    after = 'telescope.nvim',
    requires = { { 'tami5/sqlite.lua' } },
  },
  {
    'nvim-telescope/telescope-smart-history.nvim',
    opt = true,
    after = 'telescope.nvim',
    requires = { { 'tami5/sqlite.lua' } },
  },
  {
    'nvim-telescope/telescope-symbols.nvim',
    after = 'telescope.nvim',
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    after = 'telescope.nvim',
  },
  {
    'AckslD/nvim-neoclip.lua',
    requires = {
      { 'tami5/sqlite.lua' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = true,
  },
  -- { 'Shatur/neovim-session-manager' },
  {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFindFile', 'NvimTreeRefresh', 'NvimTreeFocus' },
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
    'jiaoshijie/undotree',
    cmd = 'UndotreeToggle',
  },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = true,
  },
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
    config = function()
      require('Comment').setup()
    end,
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
    config = function()
      require('surround').setup { mappings_style = 'surround' }
    end,
  },
  {
    'ggandor/leap.nvim',
    config = true,
  },
  {
    'ggandor/flit.nvim',
    after = { 'leap.nvim' },
  },
  {
    'ggandor/leap-spooky.nvim',
    after = { 'leap.nvim' },
  },
  {
    'abecodes/tabout.nvim',
    after = { 'nvim-cmp', 'nvim-treesitter' },
    config = function()
      require('tabout').setup {}
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead', 'BufNewFile' },
    requires = { 'nvim-lua/plenary.nvim' },
    config = true,
  },
  {
    'gpanders/editorconfig.nvim',
    opt = true,
    event = { 'BufRead', 'BufNewFile' },
  },

  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    requires = {
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
      { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
      { 'uga-rosa/cmp-dictionary', after = 'nvim-cmp' },
    },
    config = true,
  },
  {
    'L3MON4D3/LuaSnip',
    module = 'luasnip',
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
    'neovim/nvim-lspconfig',
    config = true,
    --event = 'BufReadPre',
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
    -- 'b0o/schemastore.nvim',
    'SchemaStore.nvim',
    module = 'schemastore',
    is_local = true,
  },
}

require('util.packer').setup {
  plugins = plugins,
  config = config,
}
